require 'bitmap'
require 'commands/create'
require 'commands/colour'

describe Commands::Colour do
  let(:bitmap) { Bitmap.new }
  let(:x) { 2 }
  let(:y) { 3 }
  let(:colour) { 'N' }

  subject { described_class.new(bitmap, x, y, colour) }

  before do
    Commands::Create.new(bitmap, 5, 6).execute
  end

  describe '.initialize' do
    context 'when passing a valid argument' do
      it { expect(subject.bitmap).to eq(bitmap) }
    end

    context 'when passing an invalid argument' do
      it { expect{described_class.new}.to raise_error(ArgumentError) }
    end
  end

  describe '#execute' do
    context 'when valid arguments' do
      let(:expected_array) {
        [
          ['O','O','O','O','O'],
          ['O','O','O','O','O'],
          ['O','N','O','O','O'],
          ['O','O','O','O','O'],
          ['O','O','O','O','O'],
          ['O','O','O','O','O']
        ]
      }

      before { subject.execute }

      it 'fills the bitmap image on the specified coordinates' do
        expect(subject.bitmap.image).to eq expected_array
      end
    end
  end

  describe '#valid?' do
    context 'when @bitmap is not a Bitmap object' do
      it 'raises Errors::InvalidObject' do
        expect(described_class.new('StringSample', x, y, colour).valid?).to eq false
      end
    end

    context 'when x coordinate is invalid' do
      it 'returns false' do
        expect(described_class.new(bitmap, 'a', y, colour).valid?).to eq false
      end
    end

    context 'when y coordinate is invalid' do
      it 'returns false' do
        expect(described_class.new(bitmap, x, 'b', colour).valid?).to eq false
      end
    end
  end
end