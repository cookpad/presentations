require "time"

module Presentations
  module Page
    class SpeackerDeck
      def initialize(document)
        @document = document
      end

      def date
        Time.parse(@document.search("mark")[0].inner_text).to_date
      end

      def image_url
        @document.search(%{meta[property="og:image"]})[0]["content"]
      end
    end
  end
end
