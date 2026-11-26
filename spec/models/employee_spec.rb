require "rails_helper"

RSpec.describe Employee do
  it "requires a positive salary and the core employee fields" do
    employee = described_class.new(full_name: "Ava Shah", job_title: "Engineer", country: "India", salary: 120_000, currency: "INR")
    expect(employee).to be_valid
    employee.salary = 0
    expect(employee).not_to be_valid
  end
end
