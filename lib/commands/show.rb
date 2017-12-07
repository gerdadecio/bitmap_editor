module Commands
  class Show
    attr_accessor :bitmap, :error

    def initialize(bitmap)
      @bitmap = bitmap
      @error = nil
    end

    def execute
      bitmap.show
    end

    def valid?
      begin
        bitmap.validate_image!
      rescue => e
        @error = e
      end
      !@error
    end
  end
end