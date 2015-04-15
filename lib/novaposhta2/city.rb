module Novaposhta2
  class City < Base
    attr_reader :description, :description_ru, :ref

    def initialize(params)
      @description = params['Description']
      @description_ru = params['DescriptionRu']
      @ref = params['Ref']
    end

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

    def person(firstname, lastname, phone)
      Person.new(self, firstname, lastname, phone)
    end

    class << self

      def find_by_ref(ref)
        query(Ref: ref).first
      end

      def match(name)
        query(FindByString: name)
      end

      def find(name)
        m = match(name)
        m.count == 1 ? m[0] : nil
      end

      alias [] find

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