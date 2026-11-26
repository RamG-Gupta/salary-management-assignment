class Employee < ApplicationRecord
  validates :full_name, :job_title, :country, :currency, presence: true
  validates :salary, numericality: { greater_than: 0 }
  validates :email, uniqueness: true, allow_blank: true

  scope :search, ->(query) { query.present? ? where("full_name ILIKE :q OR job_title ILIKE :q OR email ILIKE :q", q: "%#{sanitize_sql_like(query)}%") : all }
end
