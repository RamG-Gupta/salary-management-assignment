require "csv"

first_names = File.readlines(Rails.root.join("db/data/first_names.txt"), chomp: true)
last_names = File.readlines(Rails.root.join("db/data/last_names.txt"), chomp: true)
countries = [ [ "India", "INR" ], [ "United States", "USD" ], [ "United Kingdom", "GBP" ], [ "Germany", "EUR" ], [ "Singapore", "SGD" ] ]
roles = [ "Software Engineer", "Product Manager", "Designer", "Data Analyst", "HR Partner", "Sales Manager" ]
now = Time.current
rows = Array.new(10_000) do |i|
  country, currency = countries[(i / 2_000) % countries.length]
  first = first_names[(i * 7) % first_names.length]
  last = last_names[(i / first_names.length) % last_names.length]
  { full_name: "#{first} #{last}", job_title: roles[i % roles.length], country: country,
    salary: 45_000 + ((i * 7919) % 105_000), currency: currency,
    department: %w[Engineering Product People Operations Finance Sales][i % 5],
    email: "employee#{i + 1}@example.org", hire_date: Date.new(2018 + i % 8, 1 + i % 12, 1), created_at: now, updated_at: now }
end
rows.each_slice(1_000) { |batch| Employee.upsert_all(batch, unique_by: :index_employees_on_email) }
puts "Upserted #{rows.length} employees in batches of 1,000"
