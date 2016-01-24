module Vocabulary
  # Ask least frequently asked word.
  # FIXME: what about the questions that have never been asked?
  class LeastFrequentlyAskedStrategy
    def initialize(dictionary, answer_log)
      @dictionary = dictionary
      @words = dictionary.words
      @answer_log = answer_log
    end

    def next_question
      min_entry =
        @answer_log
        .entries
        .group_by { |entry| entry[:word] }
        .map { |word, entries| [word, entries.count] }
        .to_h
        .min_by { |_, count| count }

      puts "Asked #{min_entry[1]} times" unless min_entry.nil?
      # TODO: what if words is empty
      min_entry.nil? ? @dictionary.get(@words[0]) : @dictionary.get(min_entry[0])
    end
  end
end
