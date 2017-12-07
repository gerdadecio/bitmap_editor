require 'errors'
require 'common'

module Commands
  class Create
    attr_accessor :bitmap, :row, :col, :error

    def initialize(bitmap, row, col)
      @bitmap = bitmap
      @error = nil
      @row = row
      @col = col
    end

    def execute
      bitmap.col, bitmap.row = col.to_i, row.to_i
      bitmap.image = Array.new(bitmap.col) { Array.new(bitmap.row, 'O')}
    end

    def valid?
      raise @error = Errors::InvalidObject.new unless bitmap.is_a? Bitmap
      raise @error = Errors::InvalidType.new(row.class.to_s, 'Integer') unless Common.integer?(row)
      raise @error = Errors::InvalidType.new(col.class.to_s, 'Integer') unless Common.integer?(col)
      raise @error = Errors::OutOfRange.new if Common.out_of_range?(row, col)
      !@error
    end

  end
end