require 'errors'
require 'common'
require 'commands/colour'

module Commands
  class DrawHorizontal
    attr_accessor :bitmap, :error

    def initialize(bitmap, x1, x2, y, colour)
      @bitmap = bitmap
      @error = nil
      @x1 = x1
      @x2 = x2
      @y = y
      @colour = colour
    end

    def execute
      first, last = @x1.to_i, @x2.to_i
      first, last = last, first if first > last

      (first..last).each do |x|
        clr = Commands::Colour.new(bitmap, x, @y.to_i, @colour)
        @bitmap.image = clr.bitmap.image if clr.valid? && clr.execute
      end
    end

    def valid?
      raise Errors::InvalidObject.new unless bitmap.is_a? Bitmap
      bitmap.validate_image!

      @error ||= Errors::InvalidType.new(@x1.class.to_s, 'Integer') unless Common.integer?(@x1)
      @error ||= Errors::InvalidType.new(@x2.class.to_s, 'Integer') unless Common.integer?(@x2)
      @error ||= Errors::InvalidType.new(@y.class.to_s, 'Integer') unless Common.integer?(@y)
      @error ||= Errors::InvalidColor.new(@colour) unless Common.valid_colour?(@colour)
      if Common.out_of_range?(@x1, @y, @bitmap) || Common.out_of_range?(@x2, @y, @bitmap)
        @error ||= Errors::OutOfRange.new(
          "Bitmap size is [#{@bitmap.row}, #{@bitmap.col}], given coordinates are out of range"
        )
      end
      !@error
    end
  end
end