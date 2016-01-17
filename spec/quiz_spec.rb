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
      @answer_log = spy('answer_log')
      @question = Vocabulary::DictionaryEntry.new(definition: 'text', word: 'aaa')
      @quiz = Vocabulary::Quiz.new(
        answer_log: @answer_log
      )
    end

    context 'correct answer' do
      before do
        @answer = 'aaa'
        @result = @quiz.process_answer(@question, @answer)
      end

      it 'returns true' do
        expect(@result).to be_truthy
      end

      it 'logs the answer' do
        expect(@answer_log).to have_received(:log).with(@question, @answer)
      end
    end

    # TODO: test different cases
    # TODO: test whitespaces
    context 'incorrect answer' do
      before do
        @answer = 'bbb'
        @result = @quiz.process_answer(@question, @answer)
      end

      it 'returns false' do
        expect(@result).to be_falsy
      end

      it 'logs the answer' do
        expect(@answer_log).to have_received(:log).with(@question, @answer)
      end
    end
  end
end
