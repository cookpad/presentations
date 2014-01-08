module Presentations
  class Collector
    def self.collect(*args)
      new(*args).collect
    end

    def initialize(urls)
      @urls = urls
    end

    def collect
      @urls.inject([]) do |presentations, url|
        sleep 1
        case page = Presentations::Fetcher.fetch(url)
        when nil
          presentations
        else
          presentations << Presentation.new(url, page)
        end
      end
    end
  end
end
