module Novaposhta2
  # Represents a known city.
  class City < Base
    attr_reader :description, :description_ru, :ref # :nodoc:

    def initialize(params)
      @description = params['Description']
      @description_ru = params['DescriptionRu']
      @ref = params['Ref']
    end

    # Lists all warehouses or returns warehouse by number.
    def warehouses(number = nil)
      @warehouses ||= post('Address', 'getWarehouses', CityRef: @ref)['data'].map do |data|
        Warehouse.new(data)
      end

      if number.nil?
        @warehouses
      else
        @warehouses.find {|w| w.number == number}
      end
    end

    alias [] warehouses

    # Creates new person that belongs to the city.
    def person(firstname, lastname, phone)
      Person.new(self, firstname, lastname, phone)
    end

    class << self

      # Returns city matching +ref+.
      def find_by_ref(ref)
        query(Ref: ref).first
      end

      # Returns all cities matching a pattern.
      def match(name)
        query(FindByString: name)
      end

      # Returns a city by name or part of the name.
      # If more than one city match a +name+ - returns nil.
      def find(name)
        m = match(name)
        m.count == 1 ? m[0] : nil
      end

      alias [] find

      # Returns list of all known cities.
      def all
        match(nil)
      end

    end

    private
    def self.query(params)
      post('Address', 'getCities', params)['data'].map do |data|
        City.new(data)
      end
    end
  end
end