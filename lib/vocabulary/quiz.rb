require 'I18n'

module Vocabulary
  # Quiz.
  class Quiz
    def initialize(args)
      @strategy = args[:strategy]
      @answer_log = args[:answer_log]
      @stats_computer = args[:stats_computer]
      I18n.config.available_locales = :en
    end

    def next_question
      @strategy.next_question
    end

    def process_answer(question, answer)
      correct = normalize(question.word) == normalize(answer)
      @answer_log.log(question, answer, correct)
      print_stats(@stats_computer.compute(question.word))
      correct
    end

    private

    # Normalize word:
    # remove leading/trailing whitespaces,
    # convert to downcase,
    # remove leading "to"
    # remove accents
    def normalize(word)
      I18n.transliterate(word).strip.downcase.sub(/^to /, '')
    end

    def print_stats(stats)
      message = "Asked #{stats[:count]} time(s)."
      message += " Correct answer rate: #{stats[:correct_rate]}" if stats.key?(:correct_rate)
      puts message
    end
  end
end
