module Vocabulary
  # Class responsible for tracking and persisting questions and answers.
  class AnswerLog
    attr_reader :entries

    def initialize(file)
      @file = file
      @entries = []
      # TODO: read by line (more efficient but more difficult to tesy)
      file.read.split("\n").each do |line|
        next if line.empty?
        tokens = line.split(';')
        entry = {
          word: tokens[0],
          answer: tokens[1],
          result: tokens[2] == 'true',
          timestamp: tokens[3].to_i
        }
        @entries.push(entry)
      end
    end

    def log(question, answer, correct)
      timestamp = Time.now.to_i
      @file.puts("#{question.word};#{answer};#{correct};#{timestamp}")
      entry = {
        word: question.word,
        answer: answer,
        result: correct,
        timestamp: timestamp
      }
      @entries.push(entry)
    end
  end
end
