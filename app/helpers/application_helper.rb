module ApplicationHelper
end
module ActionView
  class OutputBuffer < ActiveSupport::SafeBuffer
    def <<(value)
      super(value.to_s.force_encoding('UTF-8'))
    end
    alias :append= :<<
  end
end
