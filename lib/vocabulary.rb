Dir[File.dirname(__FILE__) + '/vocabulary/*.rb'].each {|file| require file }

dictionary = Vocabulary::Dictionary.new
answer_log = Vocabulary::AnswerLog.new
strategy = Vocabulary::RandomQuizStrategy.new(dictionary)
quiz = Vocabulary::Quiz.new(strategy: strategy, answer_log: answer_log)
runner = Vocabulary::QuizRunner.new(quiz)
runner.run
