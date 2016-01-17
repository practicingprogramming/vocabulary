RSpec.describe Vocabulary::AnswerLog do
  before do
    @file = double(File)
    @answer_log = Vocabulary::AnswerLog.new(@file)
  end

  describe 'log' do
    before do
      allow(@file).to receive(:puts).with('q1;a1;false;123')
      entry = Vocabulary::DictionaryEntry.new(
        word: 'q1',
        definition: 'd1'
      )
      allow(Time).to receive(:now).and_return(Time.at(123))
      @answer_log.log(entry, 'a1', false)
    end

    it 'logs quesion and answer' do
      expect(@file).to have_received(:puts).with('q1;a1;false;123')
    end
  end
end
