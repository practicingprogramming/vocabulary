RSpec.describe Vocabulary::Quiz do
  describe 'next_question' do
    before do
      @strategy = double
      allow(@strategy).to receive(:next_question).and_return('test')
      @quiz = Vocabulary::Quiz.new(
        strategy: @strategy
      )
    end

    it 'delegates to the strategy' do
      expect(@quiz.next_question).to eq('test')
    end
  end

  describe 'process_answer' do
    before do
      @answer_log = double(Vocabulary::AnswerLog)
      allow(@answer_log).to receive(:log)
      @stats_computer = double(Vocabulary::StatsComputer)
      allow(@stats_computer).to receive(:compute).with('AaA') do
        {
          count: 123,
          correct_rate: 0.123
        }
      end
      @question = Vocabulary::DictionaryEntry.new(definition: 'text', word: 'AaA')
      @quiz = Vocabulary::Quiz.new(
        answer_log: @answer_log,
        stats_computer: @stats_computer
      )
    end

    context 'exact match' do
      before do
        @answer = 'AaA'
        @result = @quiz.process_answer(@question, @answer)
      end

      it 'returns true' do
        expect(@result).to be_truthy
      end

      it 'logs the answer' do
        expect(@answer_log).to have_received(:log).with(@question, @answer, true)
      end

      it 'computes stats' do
        expect(@stats_computer).to have_received(:compute).with('AaA')
      end
    end

    context '"to"' do
      before do
        @answer = 'to AaA'
        @result = @quiz.process_answer(@question, @answer)
      end

      it 'returns true' do
        expect(@result).to be_truthy
      end
    end

    context 'accents' do
      before do
        @answer = 'to Ááa'
        @result = @quiz.process_answer(@question, @answer)
      end

      it 'returns true' do
        expect(@result).to be_truthy
      end
    end

    context 'extra whitespaces and different case' do
      before do
        @answer = '  aAa '
        @result = @quiz.process_answer(@question, @answer)
      end

      it 'returns true' do
        expect(@result).to be_truthy
      end
    end

    context 'incorrect answer' do
      before do
        @answer = 'bbb'
        @result = @quiz.process_answer(@question, @answer)
      end

      it 'returns false' do
        expect(@result).to be_falsy
      end

      it 'logs the answer' do
        expect(@answer_log).to have_received(:log).with(@question, @answer, false)
      end
    end
  end
end
