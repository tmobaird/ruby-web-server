require 'socket'
require_relative 'lib/response'

SERVER_ROOT = "tmp/web-server/"

def parse_headers(request)
  headers = {}
  request.lines[1..-1].each do |line|
    return headers if line == "\r\n"
    
    key, value = line.split(': ')
    headers[key] = value.strip
  end

  headers
end 

def parse(request)
  method, path, version = request.lines[0].split
  {
    path: path,
    method: method,
    headers: parse_headers(request)
  }
end

def prepare_response(request)
  if request.fetch(:path) == "/"
    Response.respond_with(SERVER_ROOT + "index.html")
  else
    Response.respond_with(SERVER_ROOT + request.fetch(:path))
  end
end

server  = TCPServer.new('localhost', 8080)

loop do
  client  = server.accept
  request = client.readpartial(2048)
  request_data = parse(request)

  request  = parse(request)
  response = prepare_response(request)

  puts "#{client.peeraddr[3]} #{request.fetch(:path)} - #{response.code}"

  sleep 20
  response.send(client)
  client.close
end