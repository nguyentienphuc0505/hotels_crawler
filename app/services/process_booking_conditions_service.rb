# frozen_string_literal: true

class ProcessBookingConditionsService < BaseService
  KEYS = ['booking_conditions'].freeze

  def process
    new_data = extract_values_from_data(KEYS)
    hotel.booking_conditions.concat(new_data).uniq
  end
end
