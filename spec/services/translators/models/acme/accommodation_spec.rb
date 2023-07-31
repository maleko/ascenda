require 'rails_helper'
require 'services/translators/models/acme/accommodation'

RSpec.describe Translators::Models::Acme::Accommodation do

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
  
  let(:json) {
    {
      "Id":             id,
      "DestinationId":  destination_id,
      "Name":           name,
      "Latitude":       latitude,
      "Longitude":      longitude,
      "Address":        address,
      "City":           suburb,
      "Country":        country,
      "PostalCode":     postcode,
      "Description":    info,
      "Facilities":     facilities
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
          suburb:             suburb,
          country:            country, 
          postcode:           postcode, 
          info:               info
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
  end
  
end
