require "spec_helper"

RSpec.describe "Index" do
  it "returns an html body" do
    HTTParty.get("http://localhost:8080").tap do |response|
      expect(response.code).to eq(200)
      expect(response.body).to match(/<html lang="en">/)
    end
  end

  it "returns json posts" do
    HTTParty.get("http://localhost:8080/posts.json").tap do |response|
      expect(response.code).to eq(200)
      body = JSON.parse(response.body)
      expect(body).to be_a(Array)
      expect(body.count).to eq(3)
      expect(body.first["title"]).to eq("Fellowship of the Ring")
    end
  end
end
