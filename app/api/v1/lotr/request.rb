require "net/http"
require "uri"
require "json"

module V1
  module Lotr
    class Request
      TOKEN = ENV["THE_ONE_API_KEY"]
      BASE_URL = "https://the-one-api.dev/v2"

      def self.call(http_method:, endpoint:)
        uri = URI("#{BASE_URL}#{endpoint}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request_class = case http_method.to_s.downcase
        when "get" then Net::HTTP::Get
        when "post" then Net::HTTP::Post
        when "put" then Net::HTTP::Put
        when "delete" then Net::HTTP::Delete
        else
          raise ArgumentError, "Unsupported HTTP method: #{http_method}"
        end

        request = request_class.new(uri)
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Bearer #{TOKEN}"

        response = http.request(request)
        JSON.parse(response.body)

        
        begin
          response = RestClient::Request.execute(
            method: http_method,
            url: "#{BASE_URL}#{endpoint}",
            headers: { "Content-Type" => "application/json" }
          )

          JSON.parse(response.body)
          rescue RestClient::ExceptionWithResponse => e
          {code: e.http_code, status: e.message, data: Errors.map(e.http_code)}
        end 
      end
    end
  end
end