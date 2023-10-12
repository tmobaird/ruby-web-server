class Request
  attr_reader :method, :path, :version, :headers

  def initialize(method, path, version, headers, body)
    @method = method
    @path = path
    @version = version
    @headers = headers
    @body = body
  end

  def self.parse(request)
    method, path, version = request.lines[0].split
    Request.new(method, path, version, parse_headers(request), {})
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
end
