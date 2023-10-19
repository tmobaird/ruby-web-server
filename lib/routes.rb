module Routes
  DATA = {
    "/posts" => {
      get: {
        action: "posts"
      },
      post: {
        action: "create_post"
      }
    },
    "/posts/:id" => {
      get: {
        action: "get_post"
      },
      put: {
        action: "update_post"
      }
    },
    "/comments" => {
      get: {
        action: "comments"
      }
    },
    "/params" => {
      get: {
        action: "params"
      }
    },
    "/with_body" => {
      post: {
        action: "with_body"
      }
    },
    "/sorted_posts" => {
      get: {
        action: "sorted_posts"
      }
    },
    "/test_exception" => proc do |request|
                           raise "Test Exception"
                         end
  }
end
