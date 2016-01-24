module Vocabulary
  # Ask the word with the worst correct answer rate.
  class WorstCorrectAnswerRateStrategy
    def initialize(dictionary, answer_log)
      @dictionary = dictionary
      @words = dictionary.words
      @answer_log = answer_log
    end

    def next_question
      all_asked_words = @answer_log.entries.map { |e| e[:word] }.uniq
      never_asked_words = @words - all_asked_words
      # TODO: what if words is empty
      return @dictionary.get(never_asked_words[0]) unless never_asked_words.empty?

      worst_rate_entry =
        @answer_log
        .entries
        .group_by { |entry| entry[:word] }
        .map { |word, entries| [word, correct_answer_rate(entries)] }
        .to_h
        .min_by { |_, rate| rate }

      puts "Correct answer rate: #{worst_rate_entry[1]}"
      @dictionary.get(worst_rate_entry[0])
    end

    private

    def correct_answer_rate(log_entries)
      correct = log_entries.count { |entry| entry[:result] }
      correct.to_f / log_entries.size
    end
  end
end
