module Commands
  class DrawHorizontal
    attr_accessor :bitmap

    def initialize(bitmap)
      @bitmap = bitmap
    end

    def execute(x1, x2, y, colour)
      bitmap.validate_image!

      x = bitmap.index(y)
      first = bitmap.index(x1)
      last = bitmap.index(x2)
      first, last = last, first if first > last

      (first..last).each do |y|
        bitmap.image[x][y] = colour
      end
    end
  end
end