require "spec_helper"

RSpec.describe "POST" do
  it "can take request body" do
    response = HTTParty.post("http://localhost:8080/with_body", body: {
      title: "Testing",
      description: "this is a description"
    }.to_json, headers: {
      "Content-Type": "application/json"
    })

    expect(response.code).to eq(200)
    expect(response["title"]).to eq("Testing")
    expect(response["description"]).to eq("this is a description")
  end

  it "can take request body in urlencoded form" do
    response = HTTParty.post("http://localhost:8080/with_body", body: {
      title: "Testing",
      description: "this is a description",
      nested: {
        age: 10
      }
    })

    expect(response.code).to eq(200)
    expect(response["title"]).to eq("Testing")
    expect(response["description"]).to eq("this is a description")
    expect(response["nested"]["age"]).to eq(10)
  end

  it "can take request body in form data" do
    response = HTTParty.post("http://localhost:8080/with_body", body: {
      title: "Testing",
      description: "this is a description",
      nested: {
        age: 10
      }
    }, multipart: true)

    expect(response.code).to eq(200)
    expect(response["title"]).to eq("Testing")
    expect(response["description"]).to eq("this is a description")
    expect(response["nested"]["age"]).to eq(10)
  end
end
