require 'pry'

class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show update destroy]
  before_action :authenticate_user

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
    user_id = User.where({ user_name: @current_user })[0]&.id
    params[:user] = user_id
    puts "HELLO", params
    @appointment = Appointment.new(appointment_params) #ERROR

    if @appointment.save
      # render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing => er
    p appointment_error(:missing_param)
    render json: { error: appointment_error(:missing_param) }, status: 422
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
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
    params.require(:appointment).permit(:doctor_id, :date)
  end
end
