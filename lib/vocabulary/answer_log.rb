module Vocabulary
  # Class responsible for tracking and persisting questions and answers.
  class AnswerLog
    def initialize(file)
      @file = file
    end

    def log(question, answer, correct)
      @file.puts("#{question.word};#{answer};#{correct}")
    end
  end
end
