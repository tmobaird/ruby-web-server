require "pry"

class Response
  SERVER_ROOT = "tmp/web-server/"

  attr_reader :code

  def initialize(code:, data: "")
    @response =
      "HTTP/1.1 #{code}\r\n" +
      "Content-Length: #{data.size}\r\n" +
      "\r\n" +
      "#{data}\r\n"
    @code = code
  end

  def send(client)
    client.write(@response)
  end

  class << self
    def prepare(request)
      if request.path == "/"
        Response.respond_with(SERVER_ROOT + "index.html")
      else
        Response.respond_with(SERVER_ROOT + request.path)
      end
    end

    def respond_with(path)
      if File.exist?(path)
        Response.send_ok_response(File.binread(path))
      else
        Response.send_file_not_found
      end
    end

    def send_ok_response(data)
      Response.new(code: 200, data: data)
    end

    def send_file_not_found
      Response.new(code: 404)
    end
  end
end
