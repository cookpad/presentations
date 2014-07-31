require 'erb'

module Presentations
  module View
    class Layout < Base
      TEMPLATE_PATH = File.expand_path('../../../../presentations.html.erb', __FILE__)

      def initialize(presentations)
        @presentations = presentations
      end

      def render
        erb = ERB.new(File.read(TEMPLATE_PATH))
        erb.result(binding)
      end

      private
      def presentations
        result = ""
        result << Header.render
        result << Presentations.render(@presentations)
        result << Footer.render
      end
    end
  end
end
