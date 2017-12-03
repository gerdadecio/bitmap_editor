require './lib/errors'

module Commands
  class Create
    attr_accessor :bitmap

    def initialize(bitmap)
      @bitmap = bitmap
      validate_bitmap!
    end

    def execute(row, col)
      bitmap.col, bitmap.row = col.to_i, row.to_i
      bitmap.image = Array.new(bitmap.col) { Array.new(bitmap.row, 'O')}
    end

    private

    def validate_bitmap!
      raise Errors::InvalidObject unless bitmap.is_a? Bitmap
    end
  end
end