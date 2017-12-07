require 'byebug'
require 'bitmap'
require 'errors'

describe Bitmap do
  let(:row) { 5 }
  let(:col) { 6 }

  subject { described_class.new(row, col) }

  describe '.initialize' do
    context 'when passing invalid arguments' do
      it { expect{described_class.new(1,2,4)}.to raise_error(ArgumentError) }
    end

    context 'when passing valid arguments' do
      it 'instantiates the image' do
        expect(subject.image).to eq([])
      end

      it 'instantiates the row' do
        expect(subject.row).to eq(row)
      end

      it 'instantiates the col' do
        expect(subject.col).to eq(col)
      end
    end
  end

  describe '#show' do
    let(:sample_image) {
      [
        ['O','O','O','O'],
        ['O','O','L','O'],
        ['O','A','O','O'],
        ['O','O','O','O'],
      ]
    }
    it 'outputs the image' do
      subject.image = sample_image
      expected_output = sample_image.map{|s| s.join}.join("\n")
      expect{subject.show}.to output(expected_output+ "\n").to_stdout
    end
  end

  describe '#index' do
    context 'when passing an invalid argument' do
      it { expect{subject.index}.to raise_error(ArgumentError) }
    end

    context 'when passing a bad argument' do
      it 'returns a negative value' do
        expect(subject.index('a')).to eq -1
        expect(subject.index('%')).to eq -1
        expect(subject.index('>')).to eq -1
      end
    end

    context 'when passing a valid argument' do
      it 'returns the value less than 1' do
        expect(subject.index('1')).to eq 0
        expect(subject.index('100')).to eq 99
        expect(subject.index('250')).to eq 249
        expect(subject.index('500')).to eq 499
      end
      it 'returns an integer' do
        expect(subject.index('100').is_a?(Integer)).to eq true
      end
    end
  end

  describe '#validate_image!' do
    context 'when image is not available' do
      it { expect{subject.validate_image!}.to raise_error(Errors::MissingImage) }
    end

    context 'when image is available' do
      it 'returns nil' do
        subject.image = [[1,2,3],[2,3,4]]
        expect(subject.validate_image!).to eq nil
      end
    end
  end
end