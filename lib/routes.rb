module Routes
  DATA = {
    "/posts" => "posts",
    "/comments" => "comments",
    "/test_exception" => proc do |request|
                           raise "Test Exception"
                         end
  }
end
