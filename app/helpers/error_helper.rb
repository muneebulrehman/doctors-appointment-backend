module ErrorHelper
  def appointment_error(type)
    errors = {
      index: 'Please log in to see your appointments',
      show: 'Appointment can not be found',
      missing_param: 'param is missing or the value is empty'
    }
    errors[type]
  end
end
