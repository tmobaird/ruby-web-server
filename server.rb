require "socket"
require_relative "lib/response"
require_relative "lib/request"

server = TCPServer.new("localhost", 8080)
puts "Server running at http://localhost:8080"

loop do
  client = server.accept
  request_data = client.readpartial(2048)

  request = Request.parse(request_data)
  response = Response.prepare(request)

  puts "#{client.peeraddr[3]} #{request.path} - #{response.code}"

  response.send(client)
  client.close
end
