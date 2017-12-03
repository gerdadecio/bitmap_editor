require 'byebug'
require 'bitmap'
require 'commands/create'

describe Commands::Create do
  let(:bitmap) { Bitmap.new }

  subject { described_class.new(bitmap) }

  describe '#initialize' do
    context 'when passing a valid argument' do
      it 'sets the bitmap instance' do
        expect(subject.bitmap).to eq bitmap
      end
    end

    context 'when passing an invalid argument' do
      it { expect{described_class.new}.to raise_error(ArgumentError) }
    end

    context 'when passing non-bitmap object' do
      it { expect{described_class.new('StringSample')}.to raise_error(Errors::InvalidObject) }
    end
  end

  describe '#execute' do
    context 'when passing invalid arguments' do
      it { expect{subject.execute}.to raise_error(ArgumentError) }
    end

    context 'when passing incomplete arguments' do
      it { expect{subject.execute('1')}.to raise_error(ArgumentError) }
    end

    context 'when passing bad arguments' do

      it { expect{subject.execute('a','1')}.to raise_error(Errors::InvalidType) }
    end
  end

end