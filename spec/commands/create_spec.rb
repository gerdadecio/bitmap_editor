require 'byebug'
require 'bitmap'
require 'commands/create'

describe Commands::Create do
  let(:bitmap) { Bitmap.new }
  let(:row) { 5 }
  let(:col) { 6 }

  subject { described_class.new(bitmap, row, col) }

  describe '.initialize' do
    context 'when passing a valid argument' do
      it 'sets the instance variables' do
        expect(subject.bitmap).to eq(bitmap)
        expect(subject.row).to eq(row)
        expect(subject.col).to eq(col)
      end
    end

    context 'when passing an invalid argument' do
      it { expect{described_class.new}.to raise_error(ArgumentError) }
    end
  end

  describe '#execute' do
    context 'when arguments are valid' do
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

      before { subject.execute }

      it 'sets the bitmap row' do
        expect(subject.bitmap.row).to eq(row)
      end

      it 'sets the bitmap col' do
        expect(subject.bitmap.col).to eq(col)
      end

      it 'sets the bitmap image' do
        expect(subject.bitmap.image).to eq (expected_array)
      end
    end
  end

  describe '#valid?' do
    context 'when @bitmap is not a Bitmap object' do
      it 'raises Errors::InvalidObject' do
        expect{
          described_class.new('StringSample', row, col).valid?
        }.to raise_error(Errors::InvalidObject)
      end
    end

    context 'when either row or col is not an Integer' do
      it { expect{described_class.new(bitmap, 'a','1').valid?}.to raise_error(Errors::InvalidType) }
      it { expect{described_class.new(bitmap, '1','b').valid?}.to raise_error(Errors::InvalidType) }
      it { expect{described_class.new(bitmap, '1','$').valid?}.to raise_error(Errors::InvalidType) }
    end

    context 'when row is out of range' do
      it { expect{described_class.new(bitmap, '0','1').valid?}.to raise_error(Errors::OutOfRange) }
      it { expect{described_class.new(bitmap, '251','1').valid?}.to raise_error(Errors::OutOfRange) }
    end

    context 'when col is out of range' do
      it { expect{described_class.new(bitmap, '1','0').valid?}.to raise_error(Errors::OutOfRange) }
      it { expect{described_class.new(bitmap, '1','251').valid?}.to raise_error(Errors::OutOfRange) }
    end
  end
end