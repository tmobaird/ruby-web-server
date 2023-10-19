require "spec_helper"

RSpec.describe "REST actions" do
  it "returns 200 for GET /posts" do
    response = HTTParty.get("http://localhost:8080/posts")

    expect(response.code).to eq(200)
  end

  it "returns 201 for POST /posts" do
    response = HTTParty.post("http://localhost:8080/posts", body: {title: "Hello"}.to_json, headers: {
      "Content-Type": "application/json"
    })

    expect(response.code).to eq(201)
    expect(response.body).to include("POST create post - title: Hello!")
  end

  it "returns 200 for GET /post/:id" do
    response = HTTParty.get("http://localhost:8080/posts/1")

    expect(response.code).to eq(200)
    expect(response.body).to include("GET post #1!")
  end

  it "returns 200 for PUT /post/:id" do
    response = HTTParty.put("http://localhost:8080/posts/1", body: {title: "New Title"}.to_json, headers: {
      "Content-Type": "application/json"
    })

    expect(response.code).to eq(200)
    expect(response.body).to include("PUT update post #1 - title: New Title!")
  end
end
