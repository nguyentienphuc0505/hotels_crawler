# frozen_string_literal: true

class ProcessDestinationIdService < BaseService
  KEYS = %w[DestinationId destination_id destination].freeze

  def process
    hotel.destination_id || extract_value_from_data(KEYS)
  end
end
