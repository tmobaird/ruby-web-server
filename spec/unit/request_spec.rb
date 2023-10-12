require "spec_helper"

RSpec.describe Request do
  describe "Query parameters" do
    it "can parse basic key value pair query parameters" do
      request = Request.parse("GET /test?name=thomas HTTP1.1")
      expect(request.query["name"]).to eq("thomas")
    end

    it "defaults query params to empty hash" do
      request = Request.parse("GET /test HTTP1.1")
      expect(request.query.keys.count).to eq(0)
    end
  end
end
