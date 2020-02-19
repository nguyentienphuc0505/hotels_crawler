# frozen_string_literal: true

class ProcessNameService < BaseService
  KEYS = %w[Name hotel_name name].freeze

  def process
    hotel.name || extract_value_from_data(KEYS)
  end
end
