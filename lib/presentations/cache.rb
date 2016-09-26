require 'open-uri'
require 'nokogiri'

module Presentations
  class Cache
    class Page
      def initialize(url, date, image_url)
        @url, @date, @image_url = url, date, image_url
      end
      attr_reader :url, :date, :image_url
    end

    def initialize(url = 'https://static.cookpad.com/techlife/presentations.html')
      @cache_url = url
      @html = Nokogiri::HTML(open(@cache_url, 'r', &:read))
    end

    def slide_elements
      @slide_elements ||= @html.search('.cookpad-slides-element').map do |slide|
        url = slide.at('a')&.attributes['href']&.value
        next nil unless url
        image_url = slide.at('img.cookpad-slides-image')&.attributes['src']&.value
        next nil unless image_url
        date_str = slide.attributes['data-date']&.value
        next nil unless date_str

        begin
          y,m,d = date_str.split(?-, 3)
          date = Date.new(y.to_i,m.to_i,d.to_i)
        rescue ArgumentError
          warn "Invalid data-date: #{date_str.inspect}"
          return nil
        end

        [url, Page.new(url, date, image_url)]
      end.compact.to_h
    end

    def for(url)
      slide_elements[url]
    end
  end
end
