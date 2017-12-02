module Commands
  class Clear
    attr_accessor :bitmap

    def initialize(bitmap)
      @bitmap = bitmap
    end

    def execute
      bitmap.image = Array.new(bitmap.col) { Array.new(bitmap.row, 'O')}
    end
  end
end