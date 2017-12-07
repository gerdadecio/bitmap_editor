require 'errors'

class Bitmap
  attr_accessor :col,
                :row,
                :image

  def initialize(row = 0, col = 0)
    @image = []
    @col = col.to_i
    @row = row.to_i
  end

  def show
    image.each do |datum|
      puts datum.join
    end
  end

  def index(i)
    i.to_i - 1
  end

  def validate_image!
    raise Errors::MissingImage.new if image.empty?
  end
end