RSpec.describe(Vocabulary::RandomQuizStrategy) do
  describe 'next_question' do
    before do
      @dictionary = double(Vocabulary::Dictionary)
      allow(@dictionary).to receive(:words).and_return(['aaa', 'bbb', 'ccc'])
      allow(@dictionary).to receive(:get).with('bbb').and_return(
        word: 'bbb', definition: 'bbb definition'
      )
      allow(Kernel).to receive(:rand).with(3).and_return(1)
      @strategy = Vocabulary::RandomQuizStrategy.new(@dictionary)
    end

    it 'returns random entry' do
      expect(@strategy.next_question[:definition]).to eq('bbb definition')
    end
  end
end
