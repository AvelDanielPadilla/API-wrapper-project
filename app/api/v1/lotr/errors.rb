module V1::Lotr
  class Errors
    def self.map(code)
      case code
      when 401
        "Legolas Baddie Pics unavailable"
      when 404
        "Aragorn Baddics not available!"
      else
        "My precious!"
      end
    end
  end
end




