module Presentations
  module View
    class Presentations < Base
      def initialize(presentations)
        @presentations = presentations
      end

      def render
        @presentations.sort_by(&:date).reverse.inject("") do |result, presentation|
          result << <<-EOS.gsub(/^ {10}/, "")
            <li data-date="#{presentation.date}" class="cookpad-slides-element">
              <a target="_blank" href="#{presentation.url}">
                <img class="cookpad-slides-image" src="#{presentation.image_url}" />
              </a>
            </li>
          EOS
        end
      end
    end
  end
end
