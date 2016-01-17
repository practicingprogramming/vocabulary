module Vocabulary
  # Dictionary entry.
  # Everything we know about the word:
  # the word itself, its definition, etc.
  class DictionaryEntry
    attr_reader :word
    attr_reader :definition

    def initialize(args)
      # TODO: examples
      # TODO: transcription
      @word = args[:word]
      @definition = args[:definition]
    end
  end
end
