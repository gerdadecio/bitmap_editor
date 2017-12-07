require 'bitmap'
require 'commands/create'
require 'commands/draw_horizontal'

describe Commands::DrawHorizontal do
  let(:bitmap) { Bitmap.new }
  let(:x1) { 3 }
  let(:x2) { 5 }
  let(:y) { 2 }
  let(:colour) { 'Z' }

  subject { described_class.new(bitmap, x1, x2, y, colour) }

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
          ['O','O','Z','Z','Z'],
          ['O','O','O','O','O'],
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
        expect{
          described_class.new('StringSample', x1, x2, y, colour).valid?
        }.to raise_error(Errors::InvalidObject)
      end
    end

    context 'when x1 coordinate is a' do
      it 'returns false' do
        expect(described_class.new(bitmap, 'a', x2, y, colour).valid?).to eq false
        expect(described_class.new(bitmap, '$', x2, y, colour).valid?).to eq false
        expect(described_class.new(bitmap, '0', x2, y, colour).valid?).to eq false
        expect(described_class.new(bitmap, '251', x2, y, colour).valid?).to eq false
      end
    end

    context 'when x2 coordinate is invalid' do
      it 'returns false' do
        expect(described_class.new(bitmap, x1, 'b', y, colour).valid?).to eq false
        expect(described_class.new(bitmap, x1, '$', y, colour).valid?).to eq false
        expect(described_class.new(bitmap, x1, '0', y, colour).valid?).to eq false
        expect(described_class.new(bitmap, x1, '251', y, colour).valid?).to eq false
      end
    end

    context 'when y coordinate is invalid' do
      it 'returns false' do
        expect(described_class.new(bitmap, x1, x2, 'c', colour).valid?).to eq false
        expect(described_class.new(bitmap, x1, x2, '$', colour).valid?).to eq false
        expect(described_class.new(bitmap, x1, x2, '0', colour).valid?).to eq false
        expect(described_class.new(bitmap, x1, x2, '251', colour).valid?).to eq false
      end
    end
  end
end