RSpec.describe Vocabulary::AnswerLog do
  describe 'log' do
    before do
      @file = double(File)
      allow(@file).to receive(:puts).with('q1;a1;false;123')
      allow(@file).to receive(:read) { '' }
      @answer_log = Vocabulary::AnswerLog.new(@file)
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

  describe 'entries' do
    before do
      @file = double(File)
      allow(@file).to receive(:read) do
        "q1;a1;false;123\nq2;a2;true;456"
      end
      @answer_log = Vocabulary::AnswerLog.new(@file)
    end

    it 'returns all asked questions, answers, results and timestamps' do
      entries = @answer_log.entries
      expect(entries.size).to eq(2)
      expect(entries[0][:word]).to eq('q1')
      expect(entries[0][:answer]).to eq('a1')
      expect(entries[0][:result]).to eq(false)
      expect(entries[0][:timestamp]).to eq(123)
      expect(entries[1][:word]).to eq('q2')
      expect(entries[1][:answer]).to eq('a2')
      expect(entries[1][:result]).to eq(true)
      expect(entries[1][:timestamp]).to eq(456)
    end

    it 'updates entries after logging' do
      allow(@file).to receive(:puts).with('q3;a3;false;789')
      entry = Vocabulary::DictionaryEntry.new(
        word: 'q3',
        definition: 'd3'
      )
      allow(Time).to receive(:now).and_return(Time.at(789))
      @answer_log.log(entry, 'a3', false)

      entries = @answer_log.entries
      expect(entries.size).to eq(3)
      expect(entries[2][:word]).to eq('q3')
      expect(entries[2][:answer]).to eq('a3')
      expect(entries[2][:result]).to eq(false)
      expect(entries[2][:timestamp]).to eq(789)
    end
  end
end
