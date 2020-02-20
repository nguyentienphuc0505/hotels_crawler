# frozen_string_literal: true

class ProcessBookingConditionsService < BaseService
  def process
    new_data = extract_values_from_data(keys)
    hotel.booking_conditions.concat(new_data).uniq
  end
end
