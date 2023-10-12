require "spec_helper"

RSpec.describe "Router" do
  let(:router) do
    Router.new(
      {
        "/posts" => -> { {"message" => "Hello World"} }
      }
    )
  end

  describe "#call" do
    it "returns result of calling path on routes when route exists" do
      expect(router.call("/posts", {})).to eq({"message" => "Hello World"})
    end

    it "returns nil when route does not exist" do
      expect(router.call("/not_found", {})).to eq(nil)
    end
  end
end
