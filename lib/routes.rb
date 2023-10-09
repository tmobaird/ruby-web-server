module Routes
  DATA = {
    "/posts" => proc do |request|
                  {
                    "message" => "Hello World"
                  }.to_json
                end,
    "/test_exception" => proc do |request|
                           raise "Test Exception"
                         end
  }
end
