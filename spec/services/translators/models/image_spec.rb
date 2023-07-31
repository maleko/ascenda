require 'rails_helper'
require 'services/translators/models/image'

RSpec.describe Translators::Models::Image do
  
  describe "#attributes" do
    let(:image_type)  { "room" }
    let(:description) { "Double Bed" }
    let(:url)         { "https://test.com/test.png" }
    
    let(:json) {
      {
        image_type:   image_type,
        description:  description,
        url:          url
      }.to_json
    }

    subject { described_class.from_json( json ) }

    context "attribute has trailing spaces" do
      %w{image_type description}.each do |attribute|
        let(:example) { "test test   "}
        let(attribute.to_sym) { example }

        it "should trim trailing spaces for #{attribute}" do
          expect(subject.attributes[attribute.to_sym]).to eql example.strip.capitalize 
        end
      end

      it "should handle urls" do
        expect(subject.attributes[:url]).to eq url
      end
      
    end

    context "nil values" do
      %w{image_type description url}.each do |attribute|
        let(:example) { nil }
        let(attribute.to_sym) { example }

        it "should not include empty attributes" do
          expect(subject.attributes[attribute.to_sym]).to be_nil
        end
      end
    end
  end

end
