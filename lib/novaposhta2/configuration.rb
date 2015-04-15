module Novaposhta2
  class Configuration # :nodoc:
    attr_accessor :api_key, :sender
    def initialize
      @api_key = ENV['NOVAPOSHTA_API_KEY']
    end
  end
end