module Vocabulary
  # Compute stats on words.
  class StatsComputer
    def initialize(answer_log)
      @answer_log = answer_log
    end

    def compute(word)
      total_count = 0
      correct_count = 0
      other_words_asked_since_this = 0
      @answer_log
        .entries
        .each do |entry|
          if entry[:word] == word
            total_count += 1
            correct_count += 1 if entry[:result]
            other_words_asked_since_this = 0
          else
            other_words_asked_since_this += 1
          end
        end
      stats = {}
      stats[:count] = total_count
      stats[:correct_rate] = correct_count.to_f / total_count if total_count > 0
      stats[:other_words_asked_since_this] = other_words_asked_since_this
      stats
    end
  end
end
