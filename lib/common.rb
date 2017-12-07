require './lib/errors'

class Common
  ROW_MIN = 0
  ROW_MAX = 251
  COL_MIN = 0
  COL_MAX = 251

  def self.out_of_range?(row, col, bitmap = nil)
    out_of_range = false
    row, col = row.to_i, col.to_i

    out_of_range = check_range(row, col, ROW_MAX, COL_MAX)
    out_of_range = check_range(row, col, bitmap.row + 1, bitmap.col + 1) if bitmap
    out_of_range
  end

  def self.integer?(arg)
    !(arg.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil)
  end

  def self.valid_colour?(colour)
    (colour =~ /[A-Z]/) == 0 && colour.size == 1
  end

  private

  def self.check_range(x, y, valid_x, valid_y)
    !(x > ROW_MIN && x < valid_x && y > COL_MIN && y < valid_y)
  end
end
