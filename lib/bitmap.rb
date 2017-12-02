class Bitmap
  attr_accessor :col,
                :row,
                :image

  def initialize(col = 0, row = 0)
    @image = []
    @col = col.to_i
    @row = row.to_i
  end

  def show
    image.each do |datum|
      puts datum.join
    end
  end
end