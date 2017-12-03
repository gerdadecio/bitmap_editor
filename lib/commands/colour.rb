module Commands
  class Colour
    attr_accessor :bitmap

    def initialize(bitmap)
      @bitmap = bitmap
    end

    def execute(x, y, colour)
      bitmap.validate_image!
      bitmap.image[bitmap.index(y)][bitmap.index(x)] = colour
    end
  end
end