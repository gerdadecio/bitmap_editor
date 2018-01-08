require 'bitmap'
require 'commands/create'
require 'commands/colour'

describe Commands::Fill do
  let(:bitmap) { Bitmap.new }
  let(:x) { 2 }
  let(:y) { 3 }
  let(:colour) { 'K' }

  subject { described_class.new(bitmap, x, y, colour) }
end
