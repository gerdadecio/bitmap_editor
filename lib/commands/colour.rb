require './lib/errors'

module Commands
  class Colour
    attr_accessor :bitmap, :error

    def initialize(bitmap, x, y, colour)
      @error = nil
      @bitmap = bitmap
      @x = x
      @y = y
      @colour = colour
    end

    def execute
      bitmap.image[bitmap.index(@y.to_i)][bitmap.index(@x.to_i)] = @colour
    end

    def valid?
      bitmap.validate_image!
      @error ||= Errors::InvalidType.new(@x.class.to_s, 'Integer') unless Common.integer?(@x)
      @error ||= Errors::InvalidType.new(@y.class.to_s, 'Integer') unless Common.integer?(@y)
      @error ||= Errors::OutOfRange.new if Common.out_of_range?(@x, @y)
      @error ||= Errors::OutOfRange.new(
        "Bitmap size is [#{@bitmap.row}, #{@bitmap.col}], given coordinates are out of range"
      ) if Common.out_of_range?(@x, @y, @bitmap)
      @error ||= Errors::InvalidColor.new(@colour) unless Common.valid_colour?(@colour)
      !@error
    rescue => e
      @error = e
      !@error
    end
  end
end