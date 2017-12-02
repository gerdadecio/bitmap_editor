module Commands
  class Show
    attr_accessor :bitmap

    def initialize(bitmap)
      @bitmap = bitmap
    end

    def execute
      bitmap.show
    end
  end
end