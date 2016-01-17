module Vocabulary
  # Quiz.
  class Quiz
    def initialize(args)
      @strategy = args[:strategy]
      @answer_log = args[:answer_log]
    end

    def next_question
      @strategy.next_question
    end

    def process_answer(question, answer)
      correct = question.word.chomp == answer.chomp
      @answer_log.log(question, answer, correct)
      correct
    end
  end
end
