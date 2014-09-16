require "time"

module Presentations
  module Page
    class SlideShare
      def initialize(document)
        @document = document
      end

      def date
        Time.parse(@document.search("time[itemprop=datePublished]").attribute("datetime").value).to_date
      end

      def image_url
        @document.search(".slide_image")[0]["src"]
      end
    end
  end
end
