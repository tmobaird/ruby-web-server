class Request
  class BodyParser
    ALLOWED_CONTENT_TYPES = {
      "application/json" => :json,
      "application/x-www-form-urlencoded" => :urlencoded,
      "multipart/form-data" => :form_data
    }

    def initialize(request, headers)
      @request = request
      @headers = headers
      parts = request.split("\r\n\r\n")
      @body = (parts.count > 1) ? parts[1..].join("\r\n\r\n") : nil
    end

    def parse
      return nil unless @body

      if ALLOWED_CONTENT_TYPES.key? @headers["Content-Type"]
        send(ALLOWED_CONTENT_TYPES[@headers["Content-Type"]])
      elsif @headers["Content-Type"].include? "multipart/form-data;"
        @boundary = @headers["Content-Type"].split("boundary=").last
        form_data
      end
    end

    def json
      JSON.parse(@body)
    rescue
      nil
    end

    def urlencoded
      UrlendcodedParser.new(@body).parse
    end

    def form_data
      attrs = @body.split(@boundary).filter { |f| f.include? "Content-Disposition: form-data;" }.map do |field|
        field.split("Content-Disposition: form-data; ").last.split("\r\n\r\n")
      end
      attrs.map! do |attr|
        key = attr.first.match(/name="(.+)"/).captures.first
        value = attr.last.split("\r\n--").first
        [key, value]
      end
      d = {}
      attrs.map! do |attr|
        d[attr.first] = attr.last
      end

      uri_encoded_params = URI.encode_www_form(d)
      UrlendcodedParser.new(uri_encoded_params).parse
    end
  end
end

require_relative "body_parser/urlendcoded_parser"
