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
        puts "=> #{url}"

        page = case
        when ENV['IGNORE_CACHE'] != '1' && (cached = cache.for(url))
          puts " * Cached"
          cached
        else
          need_sleep = true
          Presentations::Fetcher.fetch(url)
        end

        if page
          presentations << Presentation.new(url, page)
        end

        sleep 1 if need_sleep

        presentations
      end
    end

    def cache
      @cache ||= Cache.new
    end
  end
end
