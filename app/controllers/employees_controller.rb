class EmployeesController < ApplicationController
  def index
    employees = Employee.order("created_at DESC")
    render json: { status: "SUCCESS", message: "Loaded employees", data: employees }, status: :ok
  end

  def show
    employee = Employee.find(params[:id])
    render json: { status: "SUCCESS", message: "Loaded employee", data: employee }, status: :ok
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: { status: "SUCCESS", message: "Saved employee", data: @employee }, status: :ok
    else
      render json: { status: "ERROR", message: "employee not saved", data: @employee.errors }, status: :unprocessable_entity
    end
  end

  def update
    employee = Employee.find(params[:id])
    if employee.update_attributes(employee_params)
      render json: { status: "SUCCESS", message: "Updated employee", data: employee }, status: :ok
    else
      render json: { status: "ERROR", message: "employee not updated", data: employee.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    render json: { status: "SUCCESS", message: "Deleted employee", data: employee }, status: :ok
  end

  private

  def employee_params
    params.permit(:first_name, :last_name, :google_user_id)
  end
end
