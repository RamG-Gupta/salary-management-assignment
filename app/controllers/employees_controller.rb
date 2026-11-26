class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show update destroy]

  def index
    page = [ params.fetch(:page, 1).to_i, 1 ].max
    per_page = params.fetch(:per_page, 25).to_i.clamp(1, 100)
    relation = Employee.search(params[:query]).order(:full_name)
    render json: { employees: relation.offset((page - 1) * per_page).limit(per_page), total: relation.count, page: page, per_page: per_page }
  end

  def show
    render json: @employee
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy!
    head :no_content
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary, :currency, :department, :email, :hire_date)
  end
end
