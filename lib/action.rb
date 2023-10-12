class Action
  def initialize(request)
    @request = request
  end

  def posts
    {
      body: {
        message: "Hello World"
      }.to_json,
      headers: {
        "Content-Type": "application/json"
      }
    }
  end

  def comments
    if @request.headers["Accept"] == "application/json"
      {
        body:
          [
            {id: 1, body: "This is a comment"},
            {id: 2, body: "This is comment_two"}
          ].to_json,
        headers: {
          "Content-Type": "application/json"
        }
      }
    else
      {
        body: "I dont have anything for you",
        headers: {
          "Content-Type": "text/plain"
        }
      }
    end
  end
end
