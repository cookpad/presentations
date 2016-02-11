require 'open-uri'
require 'date'
require 'uri'

module Presentations
  module Page
    class SlideShare
      def initialize(url)
        @url = url
        fetch
      end

      attr_reader :date, :image_url, :url

      def fetch
        @date = begin
          match = oembed['slide_image_baseurl'].match(%r{-(?<year>\d{2})(?<month>\d{2})(?<day>\d{2})\d{6}.*?/.+/slide-\z})
          unless match
            raise "Can't detect date from #{oembed['slide_image_baseurl'].inspect}"
          end

          Date.new(2000 + match['year'].to_i, match['month'].to_i, match['day'].to_i)
        end

        @image_url = "https:#{oembed['slide_image_baseurl']}1#{oembed['slide_image_baseurl_suffix']}"
      end

      def oembed
        @oembed ||= JSON.parse(open("http://www.slideshare.net/api/oembed/2?url=#{URI.encode_www_form_component(@url)}&format=json", "r", &:read))
      end
    end
  end
end
