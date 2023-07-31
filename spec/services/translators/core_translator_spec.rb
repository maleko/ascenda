require 'rails_helper'
require 'services/translators/core_translator'

RSpec.describe CoreTranslator do
  
  describe ".new" do
    subject { described_class.new(url: url) }

    it "defaults the url to nil" do
      subject = described_class.new
      expect(subject.send(:url)).to be_nil
    end
    
    describe "specified url" do
      let(:url) { "https://testing.com/test" } 

      it "sets the url" do
        subject
        expect(subject.send(:url)).to eq url 
      end
    end
  end
  
  describe "#json_collection" do
    let(:url) { "https://testing.com/test" }

    subject { described_class.new(url: url) }

    describe "Net::HTTP calls" do
      it "should retrieve the json payload" do
        expect(Net::HTTP).to receive(:get)
        subject.json_collection
      end
    end

    describe "Net::HTTP does not get initialised" do
      let(:url) { nil }

      it "does nothing" do
        expect(Net::HTTP).not_to receive(:get)
        subject.json_collection
      end
    end
  end

end