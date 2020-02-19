# frozen_string_literal: true

class BaseService
  DAFAULT_VALUE = ''
  DAFAULT_VALUES = [].freeze

  attr_accessor :data, :hotel

  def initialize(data, hotel)
    self.data = data
    self.hotel = hotel
  end

  def extract_value_from_data(keys, base_data = nil)
    keys.each do |key|
      result = base_data || data
      parsed_keys = key.split('.')

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
    end

    DAFAULT_VALUE
  end

  def extract_values_from_data(keys)
    keys.each do |key|
      result = data
      parsed_keys = key.split('.')
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
    end

    DAFAULT_VALUES
  end
end
