require "spec_helper"
require "pry"

RSpec.describe "Routes" do
  it "returns a 200 with posts data" do
    response = HTTParty.get("http://localhost:8080/posts")

    body = JSON.parse(response.body)
    expect(response.code).to eq(200)
    expect(body["message"]).to eq("Hello World")
  end

  it "returns a 404 when the route or file is not found" do
    response = HTTParty.get("http://localhost:8080/not_found")

    expect(response.code).to eq(404)
  end

  it "returns a 500 when an error occurs" do
    response = HTTParty.get("http://localhost:8080/test_exception")

    expect(response.code).to eq(500)
  end
end
