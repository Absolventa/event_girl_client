require 'net/http'
require 'uri'
require 'openssl'

require 'rubygems'

module Ereignishorizont
  class Client

    VERSION = '2.0.0'

    # Class-wide configuration
    @@api_token = nil
    @@url       = nil

    attr_reader :api_token, :url

    def initialize(url = nil, api_token = nil)
      @url       = (url       || self.class.url)
      @api_token = (api_token || self.class.api_token).to_s
      raise ArgumentError.new('No url provided.') unless @url
    end

    # @deprecated Use {#send!} instead.
    def send_event(*args)
      send!(*args)
    end

    # POSTs a string to the event_girl server.
    def send!(title, content = nil)
      uri = URI.parse(url)

      # Auto-correct missing trailing slash
      path = uri.path == '' ? '/' : uri.path

      # This is all the post request stuff.
      req = Net::HTTP::Post.new(path)

      # The request format and content type is json
      req['Accept']       = "application/json"
      req['Content-Type'] = "application/json"

      # This takes the entered api token and title. This is what is sent. It is a HASH!
      req.body = '{"api_token":"' + api_token + '","incoming_event":{"title":"' + title.to_s + '","content":"' + content.to_s + '"}}'

      # The request is sent via HTTP to the host and port. You also get a response
      # ex: 201 (it worked)
      http = Net::HTTP.new(uri.host, uri.port)

      http.use_ssl = ssl?
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      http.request(req)
    end

    def self.configure
      yield self if block_given?
    end

    # class attribute accessors:
    class_variables.map{|cvar| cvar.to_s.gsub('@@', '') }.each do |cattr|
      define_singleton_method cattr do
        class_variable_get :"@@#{cattr}"
      end
      define_singleton_method "#{cattr}=" do |value|
        class_variable_set "@@#{cattr}", value
      end
    end

    private

    def ssl?
      !!/^https:/.match(url)
    end

  end
end
