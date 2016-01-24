RSpec.describe(Vocabulary::WorstCorrectAnswerRateStrategy) do
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
      context 'one word has never been asked' do
        before do
          allow(@answer_log).to receive(:entries) do
            [
              { word: 'bbb', answer: 'bbb', result: true, timestamp: 123 },
              { word: 'bbb', answer: 'bbb', result: false, timestamp: 456 }
            ]
          end
          @strategy = Vocabulary::WorstCorrectAnswerRateStrategy.new(@dictionary, @answer_log)
        end

        it 'returns the word that has never been asked' do
          expect(@strategy.next_question[:word]).to eq('aaa')
        end
      end

      context 'each word has been asked at least once' do
        before do
          allow(@answer_log).to receive(:entries) do
            [
              { word: 'aaa', answer: 'aaa', result: true, timestamp: 123 },
              { word: 'aaa', answer: 'aaa', result: true, timestamp: 456 },
              { word: 'bbb', answer: 'bbb', result: true, timestamp: 789 },
              { word: 'bbb', answer: 'bbb', result: false, timestamp: 234 }
            ]
          end
          @strategy = Vocabulary::WorstCorrectAnswerRateStrategy.new(@dictionary, @answer_log)
        end

        it 'returns the word with the worst correct answe rate' do
          expect(@strategy.next_question[:word]).to eq('bbb')
        end
      end
    end

    context 'log is empty' do
      before do
        allow(@answer_log).to receive(:entries) { [] }
        @strategy = Vocabulary::WorstCorrectAnswerRateStrategy.new(@dictionary, @answer_log)
      end

      it 'returns the first word in the dictionary' do
        expect(@strategy.next_question[:word]).to eq('aaa')
      end
    end
  end
end
