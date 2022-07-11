module ErrorHelper
  def appointment_error(type)
    errors = { index: 'Please log in to see your appointments' }
    errors[type]
  end
end
