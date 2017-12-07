require 'byebug'
require 'bitmap'
require 'commands/create'
require 'commands/draw_vertical'

describe Commands::DrawVertical do
  let(:bitmap) { Bitmap.new }
  let(:x) { 2 }
  let(:y1) { 3 }
  let(:y2) { 6 }
  let(:colour) { 'W' }

  subject { described_class.new(bitmap, x, y1, y2, colour) }

  before do
    Commands::Create.new(bitmap, 5, 6).execute
  end

  describe '.initialize' do
    context 'when passing a valid argument' do
      it { expect(subject.bitmap).to eq(bitmap) }
      it { expect(subject.error).to eq(nil) }
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
          ['O','W','O','O','O'],
          ['O','W','O','O','O'],
          ['O','W','O','O','O'],
          ['O','W','O','O','O']
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
        expect{
          described_class.new('StringSample', x, y1, 2, colour).valid?
        }.to raise_error(Errors::InvalidObject)
      end
    end

    context 'when x coordinate is invalid' do
      it 'returns false' do
        expect(described_class.new(bitmap, 'a', y1, y2, colour).valid?).to eq false
        expect(described_class.new(bitmap, '$', y1, y2, colour).valid?).to eq false
        expect(described_class.new(bitmap, '0', y1, y2, colour).valid?).to eq false
        expect(described_class.new(bitmap, '251', y1, y2, colour).valid?).to eq false
      end
    end

    context 'when y1 coordinate is invalid' do
      it 'returns false' do
        expect(described_class.new(bitmap, x, 'b', y2, colour).valid?).to eq false
        expect(described_class.new(bitmap, x, '$', y2, colour).valid?).to eq false
        expect(described_class.new(bitmap, x, '0', y2, colour).valid?).to eq false
        expect(described_class.new(bitmap, x, '251', y2, colour).valid?).to eq false
      end
    end

    context 'when y2 coordinate is invalid' do
      it 'returns false' do
        expect(described_class.new(bitmap, x, y1, 'c', colour).valid?).to eq false
        expect(described_class.new(bitmap, x, y1, '$', colour).valid?).to eq false
        expect(described_class.new(bitmap, x, y1, '0', colour).valid?).to eq false
        expect(described_class.new(bitmap, x, y1, '251', colour).valid?).to eq false
      end
    end
  end
end