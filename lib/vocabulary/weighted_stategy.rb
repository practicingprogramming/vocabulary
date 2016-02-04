module Vocabulary
  # Weighted strategy.
  # Assigns weight to each word based on:
  # - correct answer rage
  # - last time it was asked
  # - how many times it was asked
  # Picks the highest rated word.
  class WeightedStrategy
    CORRECT_RATE_WEIGHT = -5
    ASKED_WEIGHT = -5
    LAST_ASKED_WEIGHT = 10

    DEBUG = false

    def initialize(dictionary, answer_log, stats_computer)
      @dictionary = dictionary
      @words = dictionary.words
      @answer_log = answer_log
      @stats_computer = stats_computer
    end

    def next_question
      word = @words.sort { |x, y| weight(y) <=> weight(x) }.first
      print_debug_data(word) if DEBUG
      @dictionary.get(word)
    end

    def weight(word)
      stats = @stats_computer.compute(word)
      total_log_length = @answer_log.entries.length

      (stats[:correct_rate] || 0) * CORRECT_RATE_WEIGHT +
        (stats[:count].to_f / total_log_length) * ASKED_WEIGHT +
        (stats[:other_words_asked_since_this].to_f / total_log_length) * LAST_ASKED_WEIGHT
    end

    private

    # rubocop:disable all
    def print_debug_data(word)
      total_log_length = @answer_log.entries.length
      stats = @stats_computer.compute(word)
      puts "Winner weight: #{weight(word)}"
      message = 'Correct weight: '
      message += "#{stats[:correct_rate] || 0} * #{CORRECT_RATE_WEIGHT}"
      message += " = #{(stats[:correct_rate] || 0) * CORRECT_RATE_WEIGHT}"
      puts message
      message = 'Count: '
      message += "#{stats[:count].to_f / total_log_length} * #{ASKED_WEIGHT}"
      message += " = #{(stats[:count].to_f / total_log_length) * ASKED_WEIGHT}"
      puts message
      message = 'Last asked: '
      message += "#{stats[:other_words_asked_since_this].to_f / total_log_length} * #{LAST_ASKED_WEIGHT}"
      message += " = #{stats[:other_words_asked_since_this].to_f / total_log_length * LAST_ASKED_WEIGHT}"
      puts message
    end
    # rubocop:enable all
  end
end
