module Vocabulary
  class Quiz
    def initialize(args)
      @strategy = args[:strategy]
      @dictionary = args[:dictionary]
      @answer_log = args[:answer_log]
    end

    def next_question
    end

    def process_answer
    end
  end
end
