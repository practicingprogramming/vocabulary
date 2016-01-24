module Vocabulary
  # Compute stats on words.
  class StatsComputer
    def initialize(answer_log)
      @answer_log = answer_log
    end

    def compute(word)
      total_count = 0
      correct_count = 0
      @answer_log
        .entries
        .select { |entry| entry[:word] == word }
        .each do |entry|
          total_count += 1
          correct_count += 1 if entry[:result]
        end
      stats = {}
      stats[:count] = total_count
      stats[:correct_rate] = correct_count.to_f / total_count if total_count > 0
      stats
    end
  end
end
