module Novaposhta2
  # Represents a package recipient.
  class Person < Base
    attr_reader :city, :firstname, :lastname, :phone, :ref, :contact_ref # :nodoc:

    def initialize(city, firstname, lastname, phone) #:nodoc:
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

    # Creates a new package for the person.
    def package(address, options)
      Package.new(address, self, options)
    end
  end
end