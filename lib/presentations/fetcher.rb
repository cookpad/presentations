require "mechanize"
require "uri"

module Presentations
  class Fetcher
    def self.fetch(*args)
      new(*args).fetch
    end

    def initialize(url)
      @url = url
    end

    def fetch
      puts "=> #@url"
      case
      when has_speaker_deck_url?
        Presentations::Page::SpeackerDeck.new(get)
      when has_slide_share_url?
        Presentations::Page::SlideShare.new(@url)
      else
        warn "Unsupported URL: #@url"
        nil
      end
    end

    private

    def client
      @client ||= Mechanize.new
    end

    def has_speaker_deck_url?
      /speakerdeck/ === host
    end

    def has_slide_share_url?
      /slideshare/ === host
    end

    def host
      @host ||= URI(@url).host
    end

    def get
      client.get(@url)
    end
  end
end
