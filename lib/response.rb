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
    def prepare(request, router)
      if request.path == "/"
        Response.respond_with_file(SERVER_ROOT + "index.html")
      elsif request.path.include?(".")
        Response.respond_with_file(SERVER_ROOT + request.path)
      else
        begin
          Response.respond_with_data(router.call(request.path))
        rescue => exception
          Response.send_internal_error(exception)
        end
      end
    end

    def respond_with_file(path)
      if File.exist?(path)
        Response.send_ok(File.binread(path))
      else
        Response.send_not_found
      end
    end

    def respond_with_data(data)
      if data.nil?
        Response.send_not_found
      else
        Response.send_ok(data.to_s)
      end
    end

    def send_ok(data)
      Response.new(code: 200, data: data)
    end

    def send_not_found
      Response.new(code: 404)
    end

    def send_internal_error(exception)
      Response.new(code: 500, data: exception.message)
    end
  end
end
