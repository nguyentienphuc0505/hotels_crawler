# frozen_string_literal: true

class ProcessNameService < BaseService
  def process
    hotel.name || extract_value_from_data(keys)
  end
end
