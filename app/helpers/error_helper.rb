module ErrorHelper
  def appointment_error(type)
    errors = {
      index: 'Please log in to see your appointments',
      show: 'Appointment can not be found'
      # missing_param: 'param is missing or the value is empty',
      # wrong_date: 'invalid date'
    }
    errors[type]
  end
end
