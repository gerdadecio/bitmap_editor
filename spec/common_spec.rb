require 'byebug'
require 'bitmap'
require 'common'
require 'errors'

describe Common do
  describe 'constants' do
    it 'are available' do
      expect(described_class::ROW_MIN).to eq(0)
      expect(described_class::ROW_MAX).to eq(251)
      expect(described_class::COL_MIN).to eq(0)
      expect(described_class::COL_MAX).to eq(251)
    end
  end

  describe '.out_of_range?' do
    context 'when passing invalid arguments' do
      it { expect{described_class.out_of_range?}.to raise_error(ArgumentError) }
    end

    context 'when bitmap is present' do
      let(:bitmap) { Bitmap.new}

      before do
        bitmap.row, bitmap.col = 2, 2
      end

      context 'when cordinates are out of range' do
        it 'returns true' do
          expect(described_class.out_of_range?('a',2, bitmap)).to eq true
          expect(described_class.out_of_range?(2,'z', bitmap)).to eq true
          expect(described_class.out_of_range?(3,0, bitmap)).to eq true
          expect(described_class.out_of_range?(3,1, bitmap)).to eq true
          expect(described_class.out_of_range?(1,3, bitmap)).to eq true
        end
      end
      context 'when coordinates are between the range' do
        it 'returns false' do
          expect(described_class.out_of_range?(1,1, bitmap)).to eq false
          expect(described_class.out_of_range?(2,1, bitmap)).to eq false
          expect(described_class.out_of_range?(1,2, bitmap)).to eq false
          expect(described_class.out_of_range?(2,2, bitmap)).to eq false
        end
      end
    end

    context 'when bitmap is not present' do
      context 'when cordinates are out of range' do
        it 'returns true' do
          expect(described_class.out_of_range?('a',2)).to eq true
          expect(described_class.out_of_range?(2,'z')).to eq true
          expect(described_class.out_of_range?(0,10)).to eq true
          expect(described_class.out_of_range?(251,10)).to eq true
          expect(described_class.out_of_range?(10,0)).to eq true
          expect(described_class.out_of_range?(10,251)).to eq true
        end
      end
      context 'when coordinates are between the range' do
        it 'returns false' do
          expect(described_class.out_of_range?(1,1)).to eq false
          expect(described_class.out_of_range?(250,1)).to eq false
          expect(described_class.out_of_range?(1,2)).to eq false
          expect(described_class.out_of_range?(2,250)).to eq false
        end
      end
    end
  end

  describe '.integer?' do
    context 'when passing invalid arguments' do
      it { expect{described_class.integer?}.to raise_error(ArgumentError) }
    end
    context 'when passing an integer' do
      it 'returns true' do
        expect(described_class.integer?(1)).to eq true
        expect(described_class.integer?(1.23)).to eq true
        expect(described_class.integer?(0)).to eq true
      end
    end
    context 'when passing a non-integer' do
      it 'returns false' do
        expect(described_class.integer?('a')).to eq false
        expect(described_class.integer?('$')).to eq false
      end
    end
  end

  describe '.valid_colour?' do
    context 'when passing invalid arguments' do
      it { expect{described_class.valid_colour?}.to raise_error(ArgumentError) }
    end

    context 'when passing an integer' do
      it 'returns false' do
        expect(described_class.valid_colour?(5)).to eq false
      end
    end
    context 'when passing symbol' do
      it 'returns false' do
        expect(described_class.valid_colour?('$')).to eq false
      end
    end
    context 'when passing a small letter' do
      it 'returns false' do
        expect(described_class.valid_colour?('a')).to eq false
      end
    end
    context 'when passing a capital letter' do
      it 'returns true' do
        expect(described_class.valid_colour?('S')).to eq true
      end
    end
    context 'when passing more than 1 characters' do
      it 'returns false' do
        expect(described_class.valid_colour?('aa')).to eq false
        expect(described_class.valid_colour?('aL')).to eq false
        expect(described_class.valid_colour?('LL')).to eq false
      end
    end
  end
end