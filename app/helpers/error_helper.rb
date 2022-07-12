module ErrorHelper
  def appointment_error(type)
    errors = {
      index: 'Please log in to see your appointments',
      show: 'Appointment can not be found'
    }
    errors[type]
  end
end
