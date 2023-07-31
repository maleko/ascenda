require 'rails_helper'
require 'services/translators/models/accommodation'

RSpec.describe Translators::Models::Accommodation do
  
  describe "#attributes" do
    let(:id)              { "ABSDE" } 
    let(:destination_id)  { 123 }
    let(:name)            { "Marriott" }
    let(:latitude)        { 1.26 }
    let(:longitude)       { 103.8 }
    let(:address)         { "42 Escape to Nowhere"}
    let(:suburb)          { "Shire" }
    let(:country)         { "Singapore" }
    let(:postcode)        { "343110" }
    let(:info)            { "lorem ipsum dolor" }
    
    let(:json)            {
      {
        id:             id,
        destination_id: destination_id,
        name:           name, 
        latitude:       latitude,
        longitude:      longitude,
        address:        address,
        suburb:         suburb,
        country:        country,
        postcode:       postcode,
        info:           info
      }.to_json
    }

    subject { 
      described_class.from_json(
        json
      )
    }

    context "attribute has trailing spaces" do
      %w{id name address suburb country postcode info}.each do |attribute|
        let(:example) { "42 Test Test   "}
        let(attribute.to_sym) { example }

        it "should trim trailing spaces for #{attribute}" do
          expect(subject.attributes[attribute.to_sym]).to eql example.strip 
        end
      end
    end

    context "a context" do
      %w{id name address suburb country postcode info}.each do |attribute|
        let(:example) { nil }
        let(attribute.to_sym) { example }

        it "should not include empty attributes" do
          expect(subject.attributes[attribute.to_sym]).to be_nil
        end
      end
    end
  end
  
end
