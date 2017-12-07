module Commands
  class Clear
    attr_accessor :bitmap

    def initialize(bitmap)
      @bitmap = bitmap
      @error = nil
    end

    def execute
      bitmap.image = Array.new(bitmap.col) { Array.new(bitmap.row, 'O')}
    end

    def valid?
      true
    end
  end
end