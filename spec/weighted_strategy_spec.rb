RSpec.describe(Vocabulary::WeightedStrategy) do
  describe 'weight' do
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
      @stats_computer = Vocabulary::StatsComputer.new(@answer_log)
    end

    context 'log is not empty' do
      before do
        allow(@answer_log).to receive(:entries) do
          [
            { word: 'aaa', answer: 'aaa', result: true, timestamp: 123 },
            { word: 'aaa', answer: 'aaa', result: true, timestamp: 456 },
            { word: 'bbb', answer: 'bbb', result: true, timestamp: 789 },
            { word: 'bbb', answer: 'bbb', result: false, timestamp: 1023 }
          ]
        end
        @strategy = Vocabulary::WeightedStrategy.new(@dictionary, @answer_log, @stats_computer)
      end

      it 'calculates wheights' do
        expect(@strategy.weight('aaa')).to eq(
          1 * Vocabulary::WeightedStrategy::CORRECT_RATE_WEIGHT +
          2.0 / 4 * Vocabulary::WeightedStrategy::ASKED_WEIGHT +
          2.0 / 4 * Vocabulary::WeightedStrategy::LAST_ASKED_WEIGHT
        )
        expect(@strategy.weight('bbb')).to eq(
          0.5 * Vocabulary::WeightedStrategy::CORRECT_RATE_WEIGHT +
          2.0 / 4 * Vocabulary::WeightedStrategy::ASKED_WEIGHT +
          0 / 4 * Vocabulary::WeightedStrategy::LAST_ASKED_WEIGHT
        )
      end
    end
  end
end
