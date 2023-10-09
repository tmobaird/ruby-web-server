require "socket"
require "logger"
require "active_support/all"
require_relative "response"
require_relative "request"
require_relative "router"
require_relative "routes"

class Server
  attr_reader :port, :logger

  def initialize(port = 8080, logger = Logger.new($stdout))
    @port = port
    @server = TCPServer.new("localhost", 8080)
    @logger = logger
    @run = true
    @router = Router.new(Routes::DATA)
  end

  def start
    logger.info "Server running at http://localhost:8080"
    while @run
      client = @server.accept
      request_data = client.readpartial(2048)

      request = Request.parse(request_data)
      response = Response.prepare(request, @router)

      logger.info "#{client.peeraddr[3]} #{request.path} - #{response.code}"

      response.send(client)
      client.close
    end
  end
end
