# frozen_string_literal: true

class ProcessDescriptionService < BaseService
  KEYS = %w[Description info].freeze

  def process
    hotel.description || extract_value_from_data(KEYS, &:strip)
  end
end
