require 'parser'

describe Parser do
  subject { Parser.new }

  describe '#parse' do
    context 'when file does not exists' do
      it do
        expect {
          subject.parse('/test/for/incorrect/path/')
        }.to raise_error(Errors::IncorrectFile)
      end
    end

    context 'when file exists' do
      let(:expected_output) {
        [
          { "I"=>["5", "6"] },
          { "L"=>["1", "3", "A"] },
          { "V"=>["2", "3", "6", "W"] },
          { "H"=>["3", "5", "2", "Z"] },
          { "S"=>[] }
        ]
      }
      it 'returns the parsed commands' do
        file = './spec/fixtures/show.txt'
        expect(subject.parse(file)).to eq expected_output
      end
    end
  end
end
