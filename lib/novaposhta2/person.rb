module Novaposhta2
  class Person < Base
    attr_reader :city, :firstname, :lastname, :phone, :ref, :contact_ref

    def initialize(city, firstname, lastname, phone)
      @city, @firstname, @lastname, @phone = city, firstname, lastname, phone

      data = post('Counterparty', 'save',
        {
          CityRef: @city.ref,
          FirstName: @firstname,
          LastName: @lastname,
          Phone: @phone,
          CounterpartyType: :PrivatePerson,
          CounterpartyProperty: :Recipient
        })['data'][0]

      @ref = data['Ref']
      @contact_ref = data['ContactPerson']['data'][0]['Ref']
    end

    def package(address, options)
      Package.new(address, self, options)
    end
  end
end