Dir[File.dirname(__FILE__) + '/vocabulary/*.rb'].each { |file| require file }

dictionary_file = File.open('dictionary.json', 'r')
dictionary = Vocabulary::Dictionary.new(dictionary_file.read)
log_file = File.open('answer_log', 'a+')
answer_log = Vocabulary::AnswerLog.new(log_file)
strategy = Vocabulary::RandomQuizStrategy.new(dictionary)
quiz = Vocabulary::Quiz.new(strategy: strategy, answer_log: answer_log)
runner = Vocabulary::QuizRunner.new(quiz)
runner.run
