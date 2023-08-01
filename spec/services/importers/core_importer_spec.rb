require 'rails_helper'
require 'services/importers/core_importer'
require 'services/translators/models/accommodation'

RSpec.describe CoreImporter do

  let(:retrieved_accommodation)     { instance_double Translators::Models::Accommodation, id: "123", attributes: retrieved_attributes }
  let(:retrieved_attributes)        { {} }
  let(:retrieved_facility)          { instance_double Translators::Models::Facility, attributes: retrieved_attributes, name: "room" }
  let(:retrieved_image)             { instance_double Translators::Models::Image, attributes: retrieved_attributes, url: image_url }
  let(:image_url)                   { "https://www.test.com/1.jpg" }
  let(:condition)                   { "can't touch this" }
  let(:retrieved_booking_condition) { [condition] }
  let(:core_importer)               { described_class.new(retrieved_accommodations: [retrieved_accommodation]) }
  let(:accommodation)               { instance_double Accommodation }
  let(:facility)                    { instance_double Facility }
  let(:image)                       { instance_double Image }
  let(:booking_condition)           { instance_double BookingCondition }
  let(:facilities)                  { double "Facilities" }
  let(:images)                      { double "Images" }
  let(:booking_conditions)          { double "Booking Conditions" }

  describe ".new" do
    subject { described_class.new(retrieved_accommodations: [retrieved_accommodation]) }
    
    it "sets the retrieved accommodation" do
      subject
      expect(subject.send(:retrieved_accommodations)).to eq [retrieved_accommodation] 
    end
  end
  
  describe "#import" do
    subject { core_importer }

    it "persists or update accommodations" do
      expect(subject).to receive(:create_or_update_accommodation).with(retrieved_accommodation: retrieved_accommodation).and_return accommodation
      subject.import
    end
    
    it "returns an array of accommodations" do
      allow(subject).to receive(:create_or_update_accommodation).and_return accommodation 
      expect(subject.import).to eq [accommodation]
    end
  end
  
  describe "#create_or_update_accommodation" do
    
    subject { core_importer.create_or_update_accommodation(retrieved_accommodation: retrieved_accommodation) }
    
    context "non-existing accommodation" do
      before do
        allow(Accommodation).to receive(:where).and_return []
        allow(Accommodation).to receive(:create).and_return accommodation
        allow(core_importer).to receive(:create_or_update_children)
      end

      it "should create a new accommodation" do
        expect(Accommodation).to receive(:create).and_return accommodation
        subject
      end
      
      it "uses the attributes of the retrieved accommodation" do
        expect(retrieved_accommodation).to receive(:attributes).and_return({})
        subject
      end

      it "updates child values" do
        expect(core_importer).to receive :create_or_update_children 
        subject
      end 

      it "returns the persisted accommodation" do
        expect(subject).to eq accommodation
      end
    end

    context "existing accommodation" do
      before do
        allow(Accommodation).to receive(:where).and_return [accommodation]
        allow(accommodation).to receive(:update).and_return accommodation 
        allow(core_importer).to receive(:create_or_update_children)
      end 
      
      it "should update the accommodation" do
        expect(accommodation).to receive(:update).with(retrieved_attributes).and_return accommodation
        subject
      end

      it "updates child values" do
        expect(core_importer).to receive :create_or_update_children 
        subject
      end

      it "returns the persisted accommodation" do
        expect(subject).to eq accommodation
      end     
    end
  end

  describe "#create_or_update_children" do
    subject { core_importer.create_or_update_children(retrieved_accommodation: retrieved_accommodation, accommodation: accommodation) } 
    
    before do
      allow(core_importer).to receive(:create_or_update_facilities).and_return([facility])
      allow(core_importer).to receive(:create_or_update_images).and_return([image])
      allow(core_importer).to receive(:create_or_update_booking_conditions).and_return([booking_condition])
    end
    
    it { expect(core_importer).to receive(:create_or_update_facilities); subject } 
    it { expect(core_importer).to receive(:create_or_update_images); subject } 
    it { expect(core_importer).to receive(:create_or_update_booking_conditions); subject } 
    
    it "returns an array of facilities, images and booking conditions" do
      expect(subject).to eq({ facilities: [facility], images: [image], booking_conditions: [booking_condition]})
    end
  end

  describe "#create_or_update_facilities" do
    subject { core_importer.create_or_update_facilities(retrieved_accommodation: retrieved_accommodation, accommodation: accommodation) } 
  
    before do
      allow(retrieved_accommodation).to receive(:facilities).and_return [retrieved_facility]
      allow(core_importer).to receive(:create_or_update_facility).and_return(facility)
    end
    
    it "creates or updates facilities" do
      expect(core_importer).to receive(:create_or_update_facility).with(retrieved_facility: retrieved_facility, accommodation: accommodation)
      subject
    end

    it "returns a list of facilities" do
      expect(subject).to eq [facility]
    end
  end
  
  describe "#create_or_update_facility" do
    before do
      allow(accommodation).to receive(:facilities).and_return(facilities)
    end
    
    context "existing facility" do
      subject { core_importer.create_or_update_facility(retrieved_facility: retrieved_facility, accommodation: accommodation) }

      before do
        allow(facilities).to receive(:where).with({name: "Room"}).and_return [facility]
        allow(facilities).to receive(:create).and_return facility
      end

      it "does not creates a facility" do
        expect(facilities).not_to receive(:create)
        subject
      end
      
      it "does a search for the facility with the correct naming standard (no trailing whitespace and capitalize)" do
        expect(facilities).to receive(:where).with({name: "Room"}).and_return [facility]
        subject
      end
      
      it { expect(subject).to eq facility  }  
    end
    
    context "nonexistent facility" do
      subject { core_importer.create_or_update_facility(retrieved_facility: retrieved_facility, accommodation: accommodation) }

      before do
        allow(facilities).to receive(:where).with({name: "Room"}).and_return []
        allow(facilities).to receive(:create).and_return facility
      end

      it "creates a facility" do
        expect(facilities).to receive(:create).with(retrieved_attributes)
        subject
      end
      
      it "does a search for the facility with the correct naming standard (no trailing whitespace and capitalize)" do
        expect(facilities).to receive(:where).with({name: "Room"}).and_return []
        subject
      end
      
      it { expect(subject).to eq facility  }  
    end
  end
  
  describe "#create_or_update_images" do
    subject { core_importer.create_or_update_images(retrieved_accommodation: retrieved_accommodation, accommodation: accommodation) } 
  
    before do
      allow(retrieved_accommodation).to receive(:images).and_return [retrieved_image]
      allow(core_importer).to receive(:create_or_update_image).and_return(image)
    end
    
    it "creates or updates image" do
      expect(core_importer).to receive(:create_or_update_image).with(retrieved_image: retrieved_image, accommodation: accommodation)
      subject
    end

    it "returns a list of images" do
      expect(subject).to eq [image]
    end
  end
  
  describe "#create_or_update_image" do
    before do
      allow(accommodation).to receive(:images).and_return(images)
    end
    
    context "existing image" do
      subject { core_importer.create_or_update_image(retrieved_image: retrieved_image, accommodation: accommodation) }

      before do
        allow(accommodation).to receive(:images).and_return images
        allow(images).to receive(:where).with({url: image_url}).and_return [image]
        allow(images).to receive(:create).and_return image
      end

      it "does not creates a image" do
        expect(images).not_to receive(:create)
        subject
      end
      
      it "does a search for the image with the url" do
        expect(images).to receive(:where).with({url: image_url}).and_return [image]
        subject
      end
      
      it { expect(subject).to eq image  }  
    end
    
    context "nonexistent image" do
      subject { core_importer.create_or_update_image(retrieved_image: retrieved_image, accommodation: accommodation) }

      before do
        allow(accommodation).to receive(:images).and_return images
        allow(images).to receive(:where).and_return []
        allow(images).to receive(:create).and_return image
      end

      it "creates a image" do
        expect(images).to receive(:create).with(retrieved_attributes)
        subject
      end
      
      it "does a search for the image with the url string" do
        expect(images).to receive(:where).with({url: image_url}).and_return []
        subject
      end
      
      it { expect(subject).to eq image  }  
    end   
  end

  describe "#create_or_update_booking_conditions" do
    subject { core_importer.create_or_update_booking_conditions(retrieved_accommodation: retrieved_accommodation, accommodation: accommodation) } 
  
    before do
      allow(retrieved_accommodation).to receive(:booking_conditions).and_return [retrieved_booking_condition]
      allow(core_importer).to receive(:create_or_update_booking_condition).and_return(booking_condition)
    end
    
    it "creates or updates booking condition" do
      expect(core_importer).to receive(:create_or_update_booking_condition).with(retrieved_booking_condition: retrieved_booking_condition, accommodation: accommodation)
      subject
    end

    it "returns a list of booking conditions" do
      expect(subject).to eq [booking_condition]
    end
  end
  
  describe "#create_or_update_booking_condition" do
    before do
      allow(accommodation).to receive(:booking_conditions).and_return(booking_conditions)
    end
    
    context "existing booking condition" do
      subject { core_importer.create_or_update_booking_condition(retrieved_booking_condition: condition, accommodation: accommodation) }

      before do
        allow(accommodation).to receive(:booking_conditions).and_return booking_conditions
        allow(booking_conditions).to receive(:where).with({condition: condition}).and_return [booking_condition]
        allow(booking_conditions).to receive(:create).and_return booking_condition
      end

      it "does not creates a booking condition" do
        expect(booking_conditions).not_to receive(:create)
        subject
      end
      
      it "does a search for the booking condition with the condition" do
        expect(booking_conditions).to receive(:where).with({condition: condition}).and_return [booking_condition]
        subject
      end
      
      it { expect(subject).to eq booking_condition }  
    end
    
    context "nonexistent booking condition" do
      subject { core_importer.create_or_update_booking_condition(retrieved_booking_condition: condition, accommodation: accommodation) }

      before do
        allow(accommodation).to receive(:images).and_return images
        allow(booking_conditions).to receive(:where).and_return []
        allow(booking_conditions).to receive(:create).and_return booking_condition
      end

      it "creates a booking condition" do
        expect(booking_conditions).to receive(:create).with(condition: condition)
        subject
      end
      
      it "does a search for the booking condition with the condition" do
        expect(booking_conditions).to receive(:where).with({condition: condition}).and_return []
        subject
      end
      
      it { expect(subject).to eq booking_condition  }  
    end       
  end

end
