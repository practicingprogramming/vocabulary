module Vocabulary
  # Class responsible for reading from and writing to console.
  class QuizRunner
    def initialize(quiz)
      @quiz = quiz
    end

    def run
      while true do
        question = @quiz.next_question
        puts "Question: #{question.definition}"
        answer = gets
        result = @quiz.process_answer(question, answer)
        puts "Result: #{result}"
      end
    end
  end
end
