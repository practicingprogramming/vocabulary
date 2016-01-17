Dir[File.dirname(__FILE__) + '/vocabulary/*.rb'].each {|file| require file }

quiz = Vocabulary::QuizRunner.new({})
quiz.run
