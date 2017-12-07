require 'bitmap_editor'

describe BitmapEditor do
  let(:bitmap) { Bitmap.new }
  let(:sample_invalid_file) { './spec/fixtures/invalid_show.txt' }
  let(:sample_file) { './spec/fixtures/show.txt' }
  let(:commands) {
    {
      'I' => 'Commands::Create',
      'C' => 'Commands::Clear',
      'L' => 'Commands::Colour',
      'V' => 'Commands::DrawVertical',
      'H' => 'Commands::DrawHorizontal',
      'S' => 'Commands::Show'
    }
  }

  subject { described_class.new }

  describe 'constants' do
    it { expect(described_class::COMMANDS).to eq(commands) }
  end

  describe '#run' do
    context 'when no argument' do
      it { expect{subject.run}.to raise_error(ArgumentError) }
    end

    context 'when passing a valid file' do
      it 'outputs the bitmap image' do
        expect{
          subject.run(sample_file)
        }.to output("OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO\n").to_stdout
      end
    end

    context 'when passing an invalid file' do
      context 'when non-existent file' do
        it 'returns an error' do
          expect{
            subject.run('invalid/path/here')
          }.to output(Errors::IncorrectFile.new.message + "\n").to_stdout
        end
      end

      context 'when one or more command is invalid' do
        let(:output_string) {
          [
            "Unrecognised command at line 2",
            "Invalid color specified. ('w' given, capital letters expected) at line 3",
            "Bitmap size is [10, 10], given coordinates are out of range at line 4",
            "OOOOOOOOOO",
            "OOOOOOOOOO",
            "OOOOOOOOOO",
            "OOOOOOOOOO",
            "OOOOOOOOOO",
            "OOOOOOOOOO",
            "OOOOOOOOOO",
            "OOOOOOOOOO",
            "OOOOOOOOOO",
            "OOZZZOOOOO",
            ""
          ].join("\n")
        }
        it 'resturns errors' do
          expect{
            subject.run(sample_invalid_file)
          }.to output(output_string).to_stdout
        end
      end
    end
  end
end