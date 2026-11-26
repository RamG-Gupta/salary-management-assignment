class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :full_name, null: false
      t.string :job_title, null: false
      t.string :country, null: false
      t.decimal :salary, precision: 14, scale: 2, null: false
      t.string :currency, null: false, default: "USD"
      t.string :department
      t.string :email
      t.date :hire_date
      t.timestamps
    end
    add_index :employees, :country
    add_index :employees, %i[country job_title]
    add_index :employees, :full_name
    add_index :employees, :email, unique: true
    add_check_constraint :employees, "salary > 0", name: "employees_salary_positive"
  end
end
