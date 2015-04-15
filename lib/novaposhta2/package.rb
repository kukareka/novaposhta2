module Novaposhta2

  # Represents a package.
  # == Options
  # [cost] *Mandatory*. Cost of the package contents, for insurance needs.
  # [description] *Mandatory*. Description of package contents.
  # [internal_number] Internal order number.
  # [payer_type] *Sender* of *Recipient*. Default: *Sender*.
  # [payment_method] *Cash* or *NonCash*. Default: *Cash*.
  # [seats] Number of boxes. Default: *1*.
  # [volume] *Mandatory*. Volume of the package in *cm*
  # [weight] *Mandatory*. Weight of the package in *kg*.

  class Package < Base
    attr_accessor :address, :recipient, :options, :ref, :tracking # :nodoc:

    def initialize(address, recipient, options = {}) # :nodoc:
      @address = address
      @recipient = recipient
      @options = options
    end

    # Get the shipping rate.
    def rate
      post('InternetDocument', 'getDocumentPrice', params)['data'][0]['Cost'].to_i
    end

    # Commit the package.
    def save
      data = post('InternetDocument', 'save', params)

      @ref = data['data'][0]['Ref']
      @tracking = data['data'][0]['IntDocNumber']
    end

    # Print package markings.
    def print
      "https://my.novaposhta.ua/orders/printMarkings/orders/#{@ref}/type/html/apiKey/#{config.api_key}"
    end

    # Get package tracking information.
    def track
      self.class.track(@tracking)
    end

    # Get tracking information by tracking number.
    def self.track(tracking)
      post('InternetDocument', 'documentsTracking', Documents: [tracking.to_s])['data'][0]
    end

    private

    def params
      {
          DateTime: (options[:date] || Time.now).strftime('%d.%m.%Y'),
          ServiceType: 'WarehouseWarehouse',
          Sender: config.sender['ref'],
          CitySender: config.sender['city'],
          SenderAddress: config.sender['address'],
          ContactSender: config.sender['contact'],
          SendersPhone: config.sender['phone'],
          Recipient: @recipient.ref,
          CityRecipient: @recipient.city.ref,
          RecipientAddress: @address.ref,
          ContactRecipient: @recipient.contact_ref,
          RecipientsPhone: @recipient.phone,
          PaymentMethod: :Cash || options[:payment_method],
          PayerType: :Sender || options[:payer_type],
          Cost: options[:cost],
          SeatsAmount: 1 || options[:seats],
          Description: options[:description],
          CargoType: 'Cargo',
          Weight: options[:weight],
          VolumeGeneral: options[:volume] || options[:width] * options[:height] * options[:depth],
          InfoRegClientBarcodes: options[:internal_number]
      }
    end
  end
end