# frozen_string_literal: true

class ProcessDescriptionService < BaseService
  def process
    hotel.description || extract_value_from_data(keys, &:strip)
  end
end
