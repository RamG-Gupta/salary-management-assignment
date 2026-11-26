require "rails_helper"

RSpec.describe "Employees API", type: :request do
  it "searches and paginates employees" do
    Employee.create!(full_name: "Ava Shah", job_title: "Engineer", country: "India", salary: 120_000, currency: "INR")
    get "/employees.json", params: { query: "Ava", page: 1, per_page: 10 }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).dig("employees", 0, "full_name")).to eq("Ava Shah")
  end

  it "creates, updates, and deletes an employee" do
    post "/employees.json", params: { employee: { full_name: "Noah Kim", job_title: "Analyst", country: "India", salary: 90_000, currency: "INR" } }
    expect(response).to have_http_status(:created)
    employee_id = JSON.parse(response.body).fetch("id")
    patch "/employees/#{employee_id}.json", params: { employee: { job_title: "Senior Analyst" } }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).fetch("job_title")).to eq("Senior Analyst")
    delete "/employees/#{employee_id}.json"
    expect(response).to have_http_status(:no_content)
  end

  it "returns country and role salary insights" do
    Employee.create!(full_name: "Ava Shah", job_title: "Engineer", country: "India", salary: 100_000, currency: "INR")
    Employee.create!(full_name: "Mia Chen", job_title: "Designer", country: "India", salary: 200_000, currency: "INR")
    get "/insights.json", params: { country: "India", job_title: "Engineer" }
    payload = JSON.parse(response.body)
    expect(payload.dig("country", "average_salary")).to eq(150_000)
    expect(payload.dig("country", "annual_payroll")).to eq(300_000)
    expect(payload.dig("job_title", "average_salary")).to eq(100_000)
  end
end
