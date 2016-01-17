module Vocabulary
  class Question
    attr_reader :text
    attr_reader :expected_answer

    def initialize(text, expected_answer)
      @text = text
      @expected_answer = expected_answer
    end
  end
end
