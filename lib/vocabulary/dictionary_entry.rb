module Vocabulary
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
