module Commands
  class Colour
    attr_accessor :bitmap

    def initialize(bitmap)
      @bitmap = bitmap
    end

    def execute(x, y, colour)
      bitmap.image[x.to_i][y.to_i] = colour
    end
  end
end