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

  def create_post
    {
      body: "POST create post - title: #{@request.body["title"]}!",
      headers: {},
      status: 201
    }
  end

  def get_post
    {
      body: "GET post ##{@request.params["id"]}!",
      headers: {}
    }
  end

  def update_post
    {
      body: "PUT update post ##{@request.params["id"]} - title: #{@request.body["title"]}!",
      headers: {}
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

  def params
    {
      body: @request.query.to_json,
      headers: {
        "Content-Type": "application/json"
      }
    }
  end

  def sorted_posts
    posts = [
      {id: 1, body: "This is a comment"},
      {id: 2, body: "This is comment_two"}
    ]
    if @request.query["direction"] == "desc"
      posts.sort! { |a, b| b[:id] <=> a[:id] }
    end

    {
      body: posts.to_json,
      headers: {
        "Content-Type": "application/json"
      }
    }
  end

  def with_body
    {
      body: @request.body.to_json,
      headers: {
        "Content-Type": "application/json"
      }
    }
  end
end
