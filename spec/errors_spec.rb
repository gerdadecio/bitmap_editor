require 'byebug'
require 'errors'

describe Errors::IncorrectFile do
  describe '.initialize' do
    it 'sets the message by default' do
      expect(described_class.new.message).to eq 'Please provide a correct file!'
    end

    it 'is a StandardError' do
      expect(described_class.new.class).to be < StandardError
    end
  end
end

describe Errors::MissingImage do
  describe '.initialize' do
    it 'sets the message by default' do
      expect(described_class.new.message).to eq 'Bitmap image missing!'
    end

    it 'is a StandardError' do
      expect(described_class.new.class).to be < StandardError
    end
  end
end

describe Errors::InvalidObject do
  describe '.initialize' do
    it 'sets the message by default' do
      expect(described_class.new.message).to eq 'Non-bitmap object!'
    end

    it 'is a StandardError' do
      expect(described_class.new.class).to be < StandardError
    end
  end
end

describe Errors::InvalidType do
  describe '.initialize' do
    it 'is a StandardError' do
      expect(described_class.new(1,2).class).to be < StandardError
    end

    context 'when passing invalid arguments' do
      it { expect{described_class.new}.to raise_error(ArgumentError) }
    end

    context 'when passing valid arguments' do
      it 'sets the message based on the arguments' do
        expect(
          described_class.new(1,2).message
        ).to eq "Invalid type of arguments (1 given, 2 expected)"
      end
    end
  end
end

describe Errors::InvalidColor do
  describe '.initialize' do
    it 'is a StandardError' do
      expect(described_class.new(1).class).to be < StandardError
    end

    context 'when passing invalid arguments' do
      it { expect{described_class.new}.to raise_error(ArgumentError) }
    end

    context 'when passing valid arguments' do
      it 'sets the message based on the arguments' do
        expect(
          described_class.new(1).message
        ).to eq "Invalid color specified. (\'1\' given, capital letters expected)"
      end
    end
  end
end

describe Errors::OutOfRange do
  describe '.initialize' do
    it 'sets the message by default' do
      expect(
        described_class.new.message
      ).to eq 'Bitmap size invalid. Provide col and row number between 1 and 250'
    end

    it 'is a StandardError' do
      expect(described_class.new.class).to be < StandardError
    end
  end
end

