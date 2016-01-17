RSpec.describe Vocabulary::Dictionary do
  # TODO: test invalid json
  before do
    @dictionary = Vocabulary::Dictionary.new(
      '{"word1": {"definition": "definition1"}, "word2": {"definition": "definition2"}}'
    )
  end

  describe 'words' do
    it 'returns words' do
      expect(@dictionary.words).to eq(['word1', 'word2'])
    end
  end

  describe 'get' do
    # TODO: missing words
    it 'returns entries' do
      expect(@dictionary.get('word1').definition).to eq('definition1')
      expect(@dictionary.get('word2').definition).to eq('definition2')
    end
  end
end
