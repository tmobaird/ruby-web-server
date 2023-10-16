class Request
  class BodyParser
    ALLOWED_CONTENT_TYPES = {
      "application/json" => :json,
      "application/x-www-form-urlencoded" => :urlencoded
    }

    def initialize(request, headers)
      @request = request
      @headers = headers
      parts = request.split("\r\n")
      @body = (parts.count > 1) ? parts.last : nil
    end

    def parse
      return nil unless @body

      if ALLOWED_CONTENT_TYPES.key? @headers["Content-Type"]
        send(ALLOWED_CONTENT_TYPES[@headers["Content-Type"]])
      end
    end

    def json
      JSON.parse(@body)
    rescue
      nil
    end

    def urlencoded
      data = {}
      keys = URI.decode_www_form(@body)
      keys.each do |key|
        data[key.first] = key.last
      end
      data
    end
  end
end
