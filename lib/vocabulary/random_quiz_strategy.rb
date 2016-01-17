module Vocabulary
  # Random strategy.
  # Choose random word.
  class RandomQuizStrategy
    def initialize(dictionary)
      @dictionary = dictionary
      @words = dictionary.words
    end

    def next_question
      @dictionary.get(@words[Kernel.rand(@words.size)])
    end
  end
end
