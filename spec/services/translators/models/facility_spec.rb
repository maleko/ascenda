require 'rails_helper'
require 'services/translators/models/facility'

RSpec.describe Translators::Models::Facility do
  
  describe "#attributes" do
    let(:category) { "room" }
    let(:name)     { "aircon" }
    
    let(:json) {
      {
        category: category,
        name:     name
      }.to_json
    }

    subject { described_class.from_json( json ) }

    context "attribute has trailing spaces" do
      %w{category name}.each do |attribute|
        let(:example) { "test test   "}
        let(attribute.to_sym) { example }

        it "should trim trailing spaces for #{attribute}" do
          expect(subject.attributes[attribute.to_sym]).to eql example.strip 
        end
      end
    end

    context "nil values" do
      %w{category name}.each do |attribute|
        let(:example) { nil }
        let(attribute.to_sym) { example }

        it "should not include empty attributes" do
          expect(subject.attributes[attribute.to_sym]).to be_nil
        end
      end
    end

  end
  

end
