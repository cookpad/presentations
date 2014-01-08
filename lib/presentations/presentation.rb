module Presentations
  class Presentation
    attr_reader :url

    def initialize(url, page)
      @url = url
      @page = page
    end

    def date
      @page.date
    end

    def image_url
      @page.image_url
    end
  end
end
