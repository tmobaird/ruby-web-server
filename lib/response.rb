require_relative "mime_typer"
require "pry"

class Response
  SERVER_ROOT = "tmp/web-server/"

  attr_reader :code

  def initialize(code:, data: "", headers: {})
    @response =
      "HTTP/1.1 #{code}\r\n" +
      "Content-Length: #{data.bytesize + 2}\r\n" +
      headers.map { |k, v| "#{k}: #{v}" }.join("\r\n") +
      ("\r\n" * 2) +
      "#{data}\r\n"
    @code = code
  end

  def send(client)
    client.write(@response)
  end

  class << self
    def prepare(request, router)
      if request.path == "/"
        Response.respond_with_file(SERVER_ROOT + "index.html")
      elsif request.path.include?(".")
        Response.respond_with_file(SERVER_ROOT + request.path)
      else
        begin
          Response.respond_with_data(router.call(request.path, request))
        rescue => exception
          send_internal_error(exception.message)
        end
      end
    end

    def respond_with_file(path)
      content_type = MimeTyper.detect_from_file(path)

      if File.exist?(path)
        send_ok(File.binread(path), "Content-Type": content_type)
      else
        send_not_found
      end
    end

    def respond_with_data(data)
      if data.nil?
        send_not_found
      else
        send_ok(data[:body], data[:headers])
      end
    end

    def send_internal_error(data = "", headers = {})
      Response.new(data: data, code: 500, headers: headers)
    end

    def send_not_found(data = "", headers = {})
      Response.new(data: data, code: 404, headers: headers)
    end

    def send_ok(data, headers = {})
      Response.new(data: data, code: 200, headers: headers)
    end

    def send(code, data, headers = {})
      Response.new(data: data, code: code, headers: headers)
    end
  end
end
