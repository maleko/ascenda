require "net/http"

class CoreTranslator
  
    def initialize(url: nil)
      @url = url
    end

    def json_collection
      @json_collection ||= Net::HTTP.get( URI(@url) ) if url
    end

    private
      attr_reader :url
end