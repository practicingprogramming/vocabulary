RSpec.describe(Vocabulary::LeastFrequentlyAskedStrategy) do
  describe 'next_question' do
    before do
      @dictionary = double(Vocabulary::Dictionary)
      allow(@dictionary).to receive(:words).and_return(['aaa', 'bbb'])
      # TODO: combine 2 allow's into one
      allow(@dictionary).to receive(:get).with('aaa').and_return(
        word: 'aaa', definition: 'aaa definition'
      )
      allow(@dictionary).to receive(:get).with('bbb').and_return(
        word: 'bbb', definition: 'bbb definition'
      )
      @answer_log = double(Vocabulary::AnswerLog)
    end

    context 'log is not empty' do
      before do
        allow(@answer_log).to receive(:entries) do
          [
            { word: 'aaa', answer: 'aaa', result: true, timestamp: 123 },
            { word: 'aaa', answer: 'aaa', result: true, timestamp: 456 },
            { word: 'bbb', answer: 'bbb', result: true, timestamp: 789 }
          ]
        end
        @strategy = Vocabulary::LeastFrequentlyAskedStrategy.new(@dictionary, @answer_log)
      end

      it 'returns least frequently asked entry' do
        expect(@strategy.next_question[:word]).to eq('bbb')
      end
    end

    context 'log is empty' do
      before do
        allow(@answer_log).to receive(:entries) { [] }
        @strategy = Vocabulary::LeastFrequentlyAskedStrategy.new(@dictionary, @answer_log)
      end

      it 'returns the first word in the dictionary' do
        expect(@strategy.next_question[:word]).to eq('aaa')
      end
    end
  end
end
