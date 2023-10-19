require "spec_helper"

RSpec.describe "Router" do
  let(:router) do
    Router.new(
      {
        "/posts" => {
          get: {
            action: -> { {"message" => "Hello World"} }
          }
        }
      }
    )
  end

  describe "#call" do
    it "returns result of calling path on routes when route exists" do
      expect(router.call("/posts", Request.new("GET", "/posts", "1.1", {}, "", {}, {}))).to eq({"message" => "Hello World"})
    end

    it "returns nil when route does not exist" do
      expect { router.call("/not_found", {}) }.to raise_error Exceptions::RouteNotFoundError
    end
  end
end
