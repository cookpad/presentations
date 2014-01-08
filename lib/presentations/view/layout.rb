module Presentations
  module View
    class Layout < Base
      def initialize(presentations)
        @presentations = presentations
      end

      def render
        result = ""
        result << Header.render
        result << Presentations.render(@presentations)
        result << Footer.render
      end
    end
  end
end
