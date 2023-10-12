require "spec_helper"

RSpec.describe "Query Params" do
  it "returns query param data as structured json" do
    response = HTTParty.get("http://localhost:8080/params?name=thomas&age=30")

    body = JSON.parse(response.body)
    expect(body["name"]).to eq("thomas")
    expect(body["age"]).to eq("30")
  end

  it "can handle sorting via query param" do
    response = HTTParty.get("http://localhost:8080/sorted_posts?direction=desc")

    expect(response.code).to eq(200)
    body = JSON.parse(response.body)
    expect(body[0]["id"]).to eq(2)
    expect(body[1]["id"]).to eq(1)
  end
end
