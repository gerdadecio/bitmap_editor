require './lib/errors'
require './lib/common'
require './lib/commands/colour'

module Commands
  class DrawVertical
    attr_accessor :bitmap, :error

    def initialize(bitmap, x, y1, y2, colour)
      @bitmap = bitmap
      @error = nil
      @x = x
      @y1 = y1
      @y2 = y2
      @colour = colour
    end

    def execute
      first, last = @y1.to_i, @y2.to_i
      first, last = last, first if first > last

      (first..last).each do |y|
        clr = Commands::Colour.new(bitmap, @x.to_i, y, @colour)
        if clr.valid? && clr.execute
          @bitmap.image = clr.bitmap.image
        else
          @error = clr.error
        end
      end
    end

    def valid?
      raise Errors::InvalidObject.new unless bitmap.is_a? Bitmap
      bitmap.validate_image!

      @error ||= Errors::InvalidType.new(@x.class.to_s, 'Integer') unless Common.integer?(@x)
      @error ||= Errors::InvalidType.new(@y1.class.to_s, 'Integer') unless Common.integer?(@y1)
      @error ||= Errors::InvalidType.new(@y2.class.to_s, 'Integer') unless Common.integer?(@y2)
      @error ||= Errors::InvalidColor.new(@colour) unless Common.valid_colour?(@colour)

      if Common.out_of_range?(@x, @y1, @bitmap) || Common.out_of_range?(@x, @y2, @bitmap)
        @error ||= Errors::OutOfRange.new(
          "Bitmap size is [#{@bitmap.row}, #{@bitmap.col}], given coordinates are out of range"
        )
      end

      !@error
    end
  end
end