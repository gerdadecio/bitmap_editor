require 'byebug'
require 'bitmap'
require 'commands/show'

describe Commands::Show do
  let(:bitmap) { Bitmap.new }
  let(:expected_array) {
    [
      ['O','O','O','O','O'],
      ['O','O','O','O','O'],
      ['O','O','O','O','O'],
      ['O','O','O','O','O'],
      ['O','O','O','O','O'],
      ['O','O','O','O','O']
    ]
  }

  subject { described_class.new(bitmap) }

  before do
    bitmap.image = expected_array
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
    context 'when there is a bitmap image' do
      it 'returns the bitmap image' do
        expect(subject.execute).to eq expected_array
      end
    end

    context 'when there is no bitmap image' do
      it 'returns an empty array' do
        bitmap.image = []
        expect(subject.execute).to eq []
      end

    end
  end

  describe '#valid?' do
    context 'when @bitmap is not a Bitmap object' do
      it 'raises Errors::InvalidObject' do
        expect(described_class.new('StringSample').valid?).to eq false
      end
    end
  end

end