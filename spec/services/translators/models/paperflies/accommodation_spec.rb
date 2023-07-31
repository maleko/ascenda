require 'rails_helper'
require 'services/translators/models/paperflies/accommodation'

RSpec.describe Translators::Models::Paperflies::Accommodation do

  booking_conditions = %w{ test1 test2 test3 }

  let(:id)              { "iJhz" }
  let(:destination_id)  { 5432 }
  let(:name)            { "Beach Villas Singapore" }
  let(:address)         { "8 Sentosa Gateway, Beach Villas" }
  let(:suburb)          { "Singapore" }
  let(:country)         { "SG" }
  let(:postcode)        { "098269" }
  let(:info)            { "This 5 star hotel is located on the coastline of Singapore" }
  
  let(:facility_1_type) { "general" }
  let(:facility_1_name) { "pool" }
  let(:facility_2_type) { "room" }
  let(:facility_2_name) { "tv" }
  let(:facility_3_name) { "aircon" }
  let(:facilities)      { 
    {
      facility_1_type => [ facility_1_name ],
      facility_2_type => [ facility_2_name, facility_3_name ]
    }
  } 
  
  let(:image_1_type)    { "rooms" }
  let(:image_2_type)    { "amenities" }
  let(:image_1_url)     { "https://www.test.com/1.jpg" }
  let(:image_2_url)     { "https://www.test.com/2.jpg" }
  let(:image_1_info)    { "Double Room" }
  let(:image_2_info)    { "Kettle" }
  let(:images)          { 
    {
      image_1_type => [{ link: image_1_url, caption: image_1_info }],
      image_2_type => [{ link: image_2_url, caption: image_2_info }]
    } 
  }

  let(:booking_details) { booking_conditions }
  
  let(:json) {
    {
      "hotel_id":           id,
      "destination_id":     destination_id,
      "hotel_name":         name,
      "location": {
        "address":          address,
        "country":          country
      },
      "details":            info,
      "amenities":          facilities,
      "images":             images,
      "booking_conditions": booking_details
    }.to_json
  }

  subject { described_class.from_json( json ) }

  describe "conversion" do
    it "should map the attributes to our naming conventions" do
      expect(subject.attributes).to eq( 
        {
          id: id,
          destination_id: destination_id,
          name: name,
          address: address,
          country: country,
          info: info, 
          booking_conditions: booking_details
        }
      )  
    end
    
    context "booking conditions" do
      subject { described_class.from_json( json ).booking_conditions }

      it { expect(subject).to include(*booking_conditions) } 
    end

    context "facilities" do
      subject { described_class.from_json( json ).facilities }

      context "first facility" do 
        it { expect(subject[0].category).to eq(facility_1_type) } 
        it { expect(subject[0].name).to eq(facility_1_name) } 
      end
      
      context "second facility" do 
        it { expect(subject[1].category).to eq(facility_2_type) } 
        it { expect(subject[1].name).to eq(facility_2_name) } 
      end

      context "third facility" do 
        it { expect(subject[2].category).to eq(facility_2_type) } 
        it { expect(subject[2].name).to eq(facility_3_name) } 
      end
    end

    context "images" do
      subject { described_class.from_json( json ).images }

      context "first image" do 
        it { expect(subject.first.image_type).to eq(image_1_type) } 
        it { expect(subject.first.description).to eq(image_1_info) } 
        it { expect(subject.first.url).to eq(image_1_url) } 
      end
      
      context "second image" do 
        it { expect(subject.last.image_type).to eq(image_2_type) } 
        it { expect(subject.last.description).to eq(image_2_info) } 
        it { expect(subject.last.url).to eq(image_2_url) } 
      end
    end
  end
  
end
