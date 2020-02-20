# frozen_string_literal: true

class ProcessLocationService < BaseService
  def process
    {
      lat: process_data_for('lat'),
      lng: process_data_for('lng'),
      address: process_data_for('address'),
      city: process_data_for('city'),
      country: process_data_for('country')
    }
  end

  private

  def process_data_for(keyword)
    hotel.location[keyword] || extract_value_from_data(keys.try(:[], keyword))
  end
end
