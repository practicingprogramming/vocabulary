require 'colorize'

module Vocabulary
  # Class responsible for reading from and writing to console.
  class QuizRunner
    CORRECT = 'Correct!'.colorize(:green).underline
    INCORRECT = 'Incorrect!'.colorize(:red).underline

    def initialize(quiz)
      @quiz = quiz
    end

    def run
      loop do
        question = @quiz.next_question
        puts "Question: #{question.definition}"
        answer = gets.chomp
        result = @quiz.process_answer(question, answer)
        puts result ? CORRECT : message_on_incorrect(question.word)
      end
    end

    private

    def message_on_incorrect(correct_answer)
      "Incorrect! The correct answer: #{correct_answer}".colorize(:red).underline
    end
  end
end
