require 'spec_helper'

describe Novaposhta2 do
  context 'configuration' do
    it 'has an API key' do
      expect(Novaposhta2.configuration.api_key).to_not be_nil
    end
  end
end