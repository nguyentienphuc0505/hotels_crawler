# frozen_string_literal: true

class BaseService
  DAFAULT_VALUE = ''
  DAFAULT_VALUES = [].freeze

  attr_accessor :data, :hotel, :keys

  def initialize(data, hotel, keys)
    self.data = data
    self.hotel = hotel
    self.keys = keys
  end

  def extract_value_from_data(assigned_key, base_data = nil)
    return DAFAULT_VALUE unless assigned_key.present?

    result = base_data || data
    parsed_keys = assigned_key.split('.')

    parsed_keys.each do |parsed_key|
      result = result.try(:[], parsed_key)
    end

    if result.present?
      if block_given?
        return yield result
      else
        return result
      end
    end

    DAFAULT_VALUE
  end

  def extract_values_from_data(assigned_key)
    return DAFAULT_VALUES unless assigned_key.present?

    result = data
    parsed_keys = assigned_key.split('.')
    parsed_keys.each do |parsed_key|
      if result.is_a?(Array)
        result
      else
        result = result.try(:[], parsed_key)
      end
    end

    if result.present? && result.is_a?(Array)
      if block_given?
        return yield result
      else
        return result
      end
    end

    DAFAULT_VALUES
  end
end
