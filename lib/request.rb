class Request
  attr_reader :method, :path, :version, :headers, :body, :query
  attr_accessor :params

  def initialize(method, path, version, headers, body, query, params = {})
    @method = method
    @path = path
    @version = version
    @headers = headers
    @body = body
    @query = query
    @params = params
  end

  def self.parse(request)
    method, fullpath, version = request.lines[0].split
    path = fullpath.split("?").first
    headers = parse_headers(request)
    Request.new(method, path, version, headers, BodyParser.new(request, headers).parse, parse_query_params(fullpath))
  end

  def self.parse_headers(request)
    headers = {}
    request.lines[1..].each do |line|
      return headers if line == "\r\n"

      key, value = line.split(": ")
      headers[key] = value.strip
    end

    headers
  end

  def self.parse_query_params(path)
    params = {}
    if path.include?("?")
      query_string = path.split("?").last
      query_string.split("&").each do |kv|
        keypair = kv.split("=")
        if keypair.length == 2
          params[keypair.first] = keypair.last
        end
      end
    end
    params
  end
end

require_relative "request/body_parser"
