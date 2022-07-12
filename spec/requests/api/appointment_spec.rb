require 'swagger_helper'

RSpec.describe 'APPOINTMENTS API', type: :request do
  first_user = User.all[0]
  path '/api/appointments' do
    get 'Retrieves existing appointments' do
      tags 'Appointments'
      consumes 'application/json'
      parameter name: 'Cookie', in: :header, type: :string

      response '200', 'appointments received' do
        let('Cookie') { "user_name=#{first_user&.user_name}" }
        appointments = Appointment.where({ user_id: first_user&.id })
        run_test! do |res|
          expect(res.body).to eq(appointments.to_json)
        end
      end

      response '422', 'invalid request' do
        let('Cookie') { 'FAKE_COOKIE' }
        run_test! do |res|
          expect(res.body).to eq({ error: appointment_error(:index) }.to_json)
        end
      end
    end
  end

  path '/api/appointments/{id}' do
    first_user = User.all[0]
    get 'Retrieves the appointment' do
      tags 'Appointments', 'Appointment'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: 'Cookie', in: :header, type: :string

      response '200', 'appointment found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 doctor_id: { type: :integer },
                 date: { type: :date },
                 created_at: { type: :date },
                 updated_at: { type: :date }
               },
               required: %w[id user_id doctor_id]

        appointments = Appointment.where({ user_id: first_user.id })
        # p 'APPOINTMENT ID = ', appointments[0].id
        let(:id) { appointments[0].id }
        let('Cookie') { "user_name=#{first_user.user_name}" }
        run_test! do |res|
          expect(res.body).to eq(appointments[0].to_json)
        end
      end

      response '404', 'appointment not found' do
        let(:id) { 'FAKE_NUMBER' }
        let('Cookie') { "user_name=#{first_user.user_name}" }
        run_test! do |res|
          expect(res.body).to eq({ error: appointment_error(:show) }.to_json)
        end
      end
    end
  end

  path '/api/appointments' do
    first_user = User.all[0]
    post 'Creates an appointment' do
      tags 'Appointments', 'Appointment'
      consumes 'application/json'
      parameter name: 'Cookie', in: :header, type: :string
      parameter name: :appointment, in: :body, schema: {
        type: :object,
        properties: {
          doctor_id: { type: :integer },
          date: { type: :date }
        },
        required: %w[doctor_id date]
      }

      response '201', 'appointment created' do
        doctor = Doctor.all[0]
        let(:appointment) { { doctor_id: doctor&.id, date: DateTime.now } }
        let('Cookie') { "user_name=#{first_user.user_name}" }
        run_test! do |res|
          expect(JSON.parse(res.body).keys).to eq(%w[id user_id doctor_id date created_at updated_at])
        end
      end

      response '422', 'missing fields' do
        let('Cookie') { "user_name=#{first_user.user_name}" }
        let(:appointment) { {} }
        run_test! do |res|
          expect(res.body).to eq({ error: { date: ["can't be blank"], doctor_id: ["can't be blank"],
                                            doctor: ['must exist'] } }.to_json)
        end
      end

      response '422', 'wrong doctor field' do
        let('Cookie') { "user_name=#{first_user.user_name}" }
        let(:appointment) { { doctor_id: 'FAKE_ID', date: DateTime.now } }
        run_test! do |res|
          expect(res.body).to eq({ error: { doctor: ['must exist'] } }.to_json)
        end
      end

      response '422', 'wrong date' do
        let('Cookie') { "user_name=#{first_user.user_name}" }
        let(:appointment) { { doctor_id: Doctor.all[0].id, date: 'FAKE_DATE' } }
        run_test!
      end
    end
  end
end
