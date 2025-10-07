module V1::Lotr
  class Client
    def self.character
      Request.call(http_method: "get", endpoint: "/character")
    end

    def self.quote
      Request.call(http_method: "get", endpoint: "/quote")
    end

    def self.book
      Request.call(http_method: "get", endpoint: "/book")
    end

    def self.chapter
      Request.call(http_method: "get", endpoint: "/chapter")
    end

    def self.movie
      Request.call(http_method: "get", endpoint: "/movie")
    end

    def self.bad_route
      Request.call(http_method: "get", endpoint: "/wrong-path")
    end
  end
end