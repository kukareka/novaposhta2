require 'spec_helper'
require 'yaml'

module Novaposhta2
  describe Package do
    # You should get your own API key and register sender credentials to create packages
    before :all do
      Novaposhta2.configuration.sender = YAML.load_file('spec/fixtures/credentials.yml')
    end

    it 'returns shipping rate, registers the package and returns printable marking url' do
      city = City['Киев']
      package = Package.new(city[1], city.person('Иван', 'Петров', '380939999933'),
        volume: 0.04, cost: 100, description: 'Test')
      expect(package.rate).to be > 10
      tracking = package.save
      expect(tracking).to be_a String
      expect(tracking.length).to be > 10
      expect(package.print.start_with?('https://my.novaposhta.ua/')).to be_truthy
    end
  end
end