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
      @answer_log.log(question, answer)
      question.word.chomp == answer.chomp
    end
  end
end
