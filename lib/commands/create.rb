module Commands
  class Create
    attr_accessor :bitmap

    def initialize(bitmap)
      @bitmap = bitmap
    end

    def execute(row, col)
      bitmap.col, bitmap.row = col.to_i, row.to_i
      bitmap.image = Array.new(bitmap.col) { Array.new(bitmap.row, '0')}
    end
  end
end