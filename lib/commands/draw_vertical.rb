module Commands
  class DrawVertical
    attr_accessor :bitmap

    def initialize(bitmap)
      @bitmap = bitmap
    end

    def execute(x, y1, y2, colour)
      x = bitmap.index(x)
      first = bitmap.index(y1)
      last = bitmap.index(y2)
      first, last = last, first if first > last

      (first..last).each do |y|
        bitmap.image[y][x] = colour
      end
    end
  end
end