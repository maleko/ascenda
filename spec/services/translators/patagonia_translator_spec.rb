require 'rails_helper'
require 'services/translators/patagonia_translator'

RSpec.describe PatagoniaTranslator do

  let(:hardcoded_url)             { "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia" }
  let(:retrieved_accommodation)   { instance_double Translators::Models::Patagonia::Accommodation }
  let(:retrieved_accommodations)  { [retrieved_accommodation] }
  
  describe ".new" do
    subject { described_class.new(url: url) }

    it "defaults the url to nil" do
      subject = described_class.new
      expect(subject.send(:url)).to eq hardcoded_url
    end
    
    describe "specified url" do
      let(:url) { "https://testing.com/test" } 

      it "sets the url" do
        subject
        expect(subject.send(:url)).to eq url 
      end
    end
  end
  
  describe "#accommodations" do
    let(:json_collection) { double "JsonCollection" }
    let(:patagonia_translator) { described_class.new }

    subject { patagonia_translator.accommodations }
    
    context "non-empty JSON collection" do
      before do
        allow(Translators::Models::Patagonia::Accommodation).to receive(:from_json).with(json_collection).and_return retrieved_accommodations
        allow(patagonia_translator).to receive(:json_collection).and_return json_collection
      end

      it "retrieves accommodations from the JSON" do
        expect(Translators::Models::Patagonia::Accommodation).to receive(:from_json).with(json_collection).and_return retrieved_accommodations
        subject
      end
    end
    
    context "empty JSON collection" do
      before do
        allow(patagonia_translator).to receive(:json_collection).and_return nil
      end
      
      it "returns nil" do
        expect(subject).to be_nil
      end

      it "doesn't attempt to process the empty collection" do
        expect(Translators::Models::Patagonia::Accommodation).not_to receive(:from_json)
        subject
      end
    end
  end

end