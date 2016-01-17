require 'json'

module Vocabulary
  # Stores words and definitions.
  # TODO: transcriptions, examples
  class Dictionary
    def initialize(json_string)
      @data = JSON
              .parse(json_string)
              .map { |entry| { word: entry[0], definition: entry[1]['definition'] } }
              .map { |entry| [entry[:word], DictionaryEntry.new(entry)] }
              .to_h
    end

    def words
      @data.keys
    end

    def get(word)
      @data[word]
    end
  end
end
