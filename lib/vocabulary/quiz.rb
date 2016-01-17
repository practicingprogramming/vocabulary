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
      correct = normalize(question.word) == normalize(answer)
      @answer_log.log(question, answer, correct)
      correct
    end

    private

    # Normalize word:
    # remove leading/trailing whitespaces,
    # convert to downcase,
    # remove leading "to"
    def normalize(word)
      word.strip.downcase.sub(/^to /, '')
    end
  end
end
