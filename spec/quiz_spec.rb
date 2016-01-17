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
      @question = Vocabulary::DictionaryEntry.new(definition: 'text', word: 'AaA')
      @quiz = Vocabulary::Quiz.new(
        answer_log: @answer_log
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
