module Routes
  DATA = {
    "/posts" => "posts",
    "/comments" => "comments",
    "/params" => "params",
    "/with_body" => "with_body",
    "/sorted_posts" => "sorted_posts",
    "/test_exception" => proc do |request|
                           raise "Test Exception"
                         end
  }
end
