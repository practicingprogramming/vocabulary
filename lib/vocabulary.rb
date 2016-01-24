require 'optparse'

Dir[File.dirname(__FILE__) + '/vocabulary/*.rb'].each { |file| require file }

# TODO: move to quiz_runner or some other unit-testable class.
# TODO: print usage
def parse_arguments
  arguments = { strategy: 'random' }
  OptionParser.new do |opt|
    opt.on('--strategy STRATEGY') { |s| arguments[:strategy] = s }
  end.parse!
  arguments
end

# TODO: move to some unit-testable class.
def create_strategy(strategy_name, dictionary, answer_log)
  case strategy_name
  when 'random'
    Vocabulary::RandomQuizStrategy.new(dictionary)
  when 'least-frequently-asked'
    Vocabulary::LeastFrequentlyAskedStrategy.new(dictionary, answer_log)
  when 'worst-correct-answer-rate'
    Vocabulary::WorstCorrectAnswerRateStrategy.new(dictionary, answer_log)
  else
    puts "Unknown strategy: #{strategy_name}"
    exit 1
  end
end

arguments = parse_arguments

dictionary_file = File.open('dictionary.json', 'r')
dictionary = Vocabulary::Dictionary.new(dictionary_file.read)
log_file = File.open('answer_log', 'a+')
answer_log = Vocabulary::AnswerLog.new(log_file)
strategy = create_strategy(arguments[:strategy], dictionary, answer_log)
stats_computer = Vocabulary::StatsComputer.new(answer_log)
quiz = Vocabulary::Quiz.new(
  strategy: strategy,
  answer_log: answer_log,
  stats_computer: stats_computer
)
runner = Vocabulary::QuizRunner.new(quiz)
runner.run
