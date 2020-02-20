# frozen_string_literal: true

class ProcessDestinationIdService < BaseService
  def process
    hotel.destination_id || extract_value_from_data(keys)
  end
end
