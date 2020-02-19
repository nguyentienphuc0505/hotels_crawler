# frozen_string_literal: true

class ProcessAmenitiesService < BaseService
  GENERAL_KEYS = ['Facilities', 'amenities', 'amenities.general'].freeze
  ROOM_KEYS = ['amenities.amenities'].freeze

  def process
    {
      general: process_amenities_for('general', GENERAL_KEYS),
      room: process_amenities_for('room', ROOM_KEYS)
    }
  end

  private

  def process_amenities_for(type, keys)
    current_value = hotel['amenities'].try(:[], type) || []
    new_general_amenities = extract_values_from_data(keys) do |items|
      items.map do |item|
        item.underscore.humanize.downcase.strip
      end
    end

    current_value.concat(new_general_amenities).uniq
  end
end
