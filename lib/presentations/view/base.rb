module Presentations
  module View
    class Base
      def self.render(*args)
        new(*args).render
      end
    end
  end
end
