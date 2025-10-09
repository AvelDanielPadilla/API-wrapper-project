require "net/http"
require "uri"
require "json"

module V1
  module Lotr
    class Request
      TOKEN = ENV["THE_ONE_API_KEY"]
      BASE_URL = "https://the-one-api.dev/v2"

      def self.call(http_method:, endpoint:)
          begin
            uri = URI("#{BASE_URL}#{endpoint}")

            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true

            request_class = case http_method.to_s.downcase
            when "get" then Net::HTTP::Get
            
            else
              raise ArgumentError, "Unsupported HTTP method: #{http_method}"
            end

            request = request_class.new(uri)
            request["Content-Type"] = "applicat ion/json"
            request["Authorization"] = "Bearer #{TOKEN}"

            response = http.request(request)
            JSON.parse(response.body)

            
              #RESTClient put before 12
              # response = RestClient::Request.execute(
              #   method: http_method,
              #   url: "#{BASE_URL}#{endpoint}",
              #   headers: { "Content-Type" => "application/json", "Authorization" => "Bearer #{TOKEN}" }
              # )

              JSON.parse(response.body)
              rescue RestClient::ExceptionWithResponse => e
              {code: e.http_code, status: e.message, data: Errors.map(e.http_code)}
          end 
      end
    end
  end
end








#   class Request
#   TOKEN = ENV["THE_ONE_API_KEY"]
#   BASE_URL = "https://the-one-api.dev/v2"

#   def self.call(http_method:, endpoint:)
#     uri = URI("#{BASE_URL}#{endpoint}")
#     http = Net::HTTP.new(uri.host, uri.port)
#     http.use_ssl = true

#     request = build_request(http_method, uri)
#     response = http.request(request)

#     handle_response(response)
#   rescue JSON::ParserError
#     {
#       status: 500,
#       error: "Invalid JSON response from server"
#     }
#   rescue StandardError => e
#     {
#       status: 500,
#       error: "Unexpected error occurred: #{e.message}"
#     }
#   end

#   private

#   # --- Build HTTP Request ---
#   def self.build_request(http_method, uri)
#     request_class = case http_method.to_s.downcase
#                     when "get"    then Net::HTTP::Get
#                     when "post"   then Net::HTTP::Post
#                     when "put"    then Net::HTTP::Put
#                     when "delete" then Net::HTTP::Delete
#                     else
#                       raise ArgumentError, "Unsupported HTTP method: #{http_method}"
#                     end

#     request = request_class.new(uri)
#     request["Content-Type"] = "application/json"
#     request["Authorization"] = "Bearer #{TOKEN}"
#     request
#   end

#   # --- Handle Response ---
#   def self.handle_response(response)
#     case response
#     when Net::HTTPSuccess
#       {
#         status: response.code.to_i,
#         data: JSON.parse(response.body)
#       }
#     when Net::HTTPNotFound
#       custom_404_response(response)
#     else
#       {
#         status: response.code.to_i,
#         error: "HTTP #{response.code} - #{response.message}",
#         body: try_parse_json(response.body)
#       }
#     end
#   end

#   # --- Custom 404 Response ---
#   def self.custom_404_response(response)
#     {
#       status: 404,
#       code: "NOT_FOUND",
#       error: "Resource not found",
#       message: "The requested resource could not be found.",
#       timestamp: Time.now.utc,
#       original_response: {
#         code: response.code,
#         message: response.message
#       }
#     }
#   end

#   # --- Safely Parse JSON ---
#   def self.try_parse_json(body)
#     JSON.parse(body)
#   rescue JSON::ParserError
#     body
#   end
# end