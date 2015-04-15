module Novaposhta2
  module Post # :nodoc:
    def self.included(base)
      base.extend(self)
    end

    def post(model, method, properties)
      post_json({apiKey: Novaposhta2.configuration.api_key, modelName: model, calledMethod: method, methodProperties: properties}.to_json)
    end

    private
    def post_json(data)
      u = URI('https://api.novaposhta.ua/v2.0/json/')
      r = Net::HTTP::Post.new(u.path)
      r.add_field 'Content-Type', 'application/json'
      r.body = data
      rs = Net::HTTP.start(u.hostname, u.port, use_ssl: u.scheme == 'https') {|h| h.request(r)}
      js = JSON.parse rs.body
      raise js['errors'].to_s if js['errors'].any?
      raise 'Novaposhta feed request failed' unless js['success']
      js
    end
  end
end