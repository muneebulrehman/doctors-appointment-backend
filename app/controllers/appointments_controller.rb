require 'pry'

class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show update destroy]
  before_action :authenticate_user

  rescue_from Date::Error, with: :invalid_date

  # GET /appointments
  def index
    # binding.pry
    if @current_user
      user = User.where({ user_name: @current_user })
      @appointments = Appointment.where({ user_id: user[0]&.id })
      render json: @appointments, status: :ok
    else
      render json: { error: appointment_error(:index) }, status: 422
    end
  end

  # GET /appointments/1
  def show
    render json: @appointment
  end

  # POST /appointments
  def create
    params[:user_id] = which_user_id
    params[:date] = params[:date]&.to_datetime

    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: { error: @appointment.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    params[:user_id] = which_user_id
    params[:date] = params[:date].to_datetime if params[:date]
    # CHECK IF USER IS UPDATING HIS APPOINTMENT
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: { error: @appointment.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: appointment_error(:show) }, status: 404
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.permit(:doctor_id, :date, :user_id)
  end

  def invalid_date
    render json: { error: appointment_error(:invalid_date) }, status: 500
  end
end
