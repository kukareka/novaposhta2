require 'json'
require 'net/http'
require 'logger'
require 'novaposhta2/configuration'
require 'novaposhta2/post'
require 'novaposhta2/base'
require 'novaposhta2/person'
require 'novaposhta2/city'
require 'novaposhta2/warehouse'
require 'novaposhta2/package'

# Novaposhta API 2.0 Gem.
# == Configuration
#
#   Novaposhta2.configure do |config|
#     config.api_key = 'Your api key'
#     config.sender = {
#       ref: 'Sender reference',
#       city: 'City reference',
#       address: 'Sender warehouse reference',
#       contact: 'Sender contact reference',
#       phone: 'Sender phone',
#     }
#   end
#

module Novaposhta2

  def self.configuration # :nodoc:
    @configuration ||= Configuration.new
  end

  def self.configure # :nodoc:
    yield configuration
  end

  # Returns a city found by name or part of the name.
  # If more than one city match +name+ - returns nil.
  def self.[](name)
    City[name]
  end

  # Returns shipment tracking information by tracking number.
  def self.track(tracking)
    Package.track(tracking)
  end



end