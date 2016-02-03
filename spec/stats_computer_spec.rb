RSpec.describe(Vocabulary::StatsComputer) do
  describe '#compute' do
    before do
      @answer_log = double(Vocabulary::AnswerLog)
      allow(@answer_log).to receive(:entries) do
        [
          { word: 'aaa', answer: 'aaa', result: true, timestamp: 123 },
          { word: 'aaa', answer: 'zzz', result: false, timestamp: 456 },
          { word: 'aaa', answer: 'aaa', result: true, timestamp: 789 },
          { word: 'bbb', answer: 'bbb', result: true, timestamp: 1012 }
        ]
      end
    end

    context 'the word has been asked' do
      it 'computes stats' do
        stats = Vocabulary::StatsComputer.new(@answer_log).compute('aaa')
        expect(stats[:count]).to eq(3)
        expect((0.67 - stats[:correct_rate]).abs < 0.01).to be_truthy
        expect(stats[:other_words_asked_since_this]).to eq(1)
      end
    end

    context 'the word has never been asked' do
      it 'computes stats, correct_rate should not be set' do
        stats = Vocabulary::StatsComputer.new(@answer_log).compute('ccc')
        expect(stats[:count]).to eq(0)
        expect(stats[:correct_rate]).to be_nil
        expect(stats[:other_words_asked_since_this]).to eq(4)
      end
    end
  end
end
