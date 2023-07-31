require 'rails_helper'
require 'services/translators/models/patagonia/accommodation'

RSpec.describe Translators::Models::Patagonia::Accommodation do

  facilities_array = %w{ Pool BusinessCenter WiFi DryCleaning Breakfast }
  
  let(:id)              { "iJhz" }
  let(:destination_id)  { 5432 }
  let(:name)            { "Beach Villas Singapore" }
  let(:latitude)        { 1.264751 }
  let(:longitude)       { 103.824006 }
  let(:address)         { "8 Sentosa Gateway, Beach Villas" }
  let(:suburb)          { "Singapore" }
  let(:country)         { "SG" }
  let(:postcode)        { "098269" }
  let(:info)            { "This 5 star hotel is located on the coastline of Singapore" }
  let(:facilities)      { facilities_array }
  let(:image_1_type)    { "rooms" }
  let(:image_2_type)    { "amenities" }
  let(:image_1_url)     { "https://www.test.com/1.jpg" }
  let(:image_2_url)     { "https://www.test.com/2.jpg" }
  let(:image_1_info)    { "Double Room" }
  let(:image_2_info)    { "Kettle" }
  let(:images)          { 
    {
      image_1_type => [{ url: image_1_url, description: image_1_info }],
      image_2_type => [{ url: image_2_url, description: image_2_info }]
    } 
  }
  
  let(:json) {
    {
      "id":               id,
      "destination_id":   destination_id,
      "name":             name,
      "lat":              latitude,
      "lng":              longitude,
      "address":          address,
      "info":             info,
      "amenities":        facilities,
      "images":           images
    }.to_json
  }

  subject { described_class.from_json( json ) }

  describe "conversion" do
    it "should map the attributes to our naming conventions" do
      expect(subject.attributes).to eq( 
        {
          id:                 id,
          destination_id:     destination_id,
          name:               name,
          latitude:           latitude.to_s,
          longitude:          longitude.to_s,
          address:            address,
          info:               info,
          booking_conditions: []
        }
      )  
    end

    context "facilities" do
      subject { described_class.from_json( json ).facilities.collect(&:name) }

      facilities_array.each do |facility|
        it "should include #{facility}" do
          expect(subject).to include facility
        end
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
