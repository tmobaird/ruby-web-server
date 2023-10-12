class MimeTyper
  def self.detect_from_file(path)
    case path.split(".").last
    when "html"
      "text/html"
    when "json"
      "application/json"
    end
  end
end
