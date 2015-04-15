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

module Novaposhta2
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.[](index)
    City[index]
  end

  def self.track(tracking)
    Package.track(tracking)
  end



end