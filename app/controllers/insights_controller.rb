class InsightsController < ApplicationController
  def show
    scope = Employee.where(country: params[:country])
    country_stats = scope.pick(Arel.sql("MIN(salary), MAX(salary), AVG(salary), COUNT(*), SUM(salary)"))
    role_stats = params[:job_title].present? ? scope.where(job_title: params[:job_title]).pick(Arel.sql("AVG(salary), COUNT(*)")) : nil
    render json: {
      country: { country: params[:country], currency: Employee.where(country: params[:country]).group(:currency).count, minimum_salary: country_stats&.first&.to_f, maximum_salary: country_stats&.second&.to_f, average_salary: country_stats&.third&.to_f, employee_count: country_stats&.fourth || 0, annual_payroll: country_stats&.fifth&.to_f },
      job_title: role_stats && { job_title: params[:job_title], average_salary: role_stats.first&.to_f, employee_count: role_stats.second || 0 }
    }
  end
end
