# frozen_string_literal: true

class ProcessAmenitiesService < BaseService
  def process
    {
      general: process_amenities_for('general'),
      room: process_amenities_for('room')
    }
  end

  private

  def process_amenities_for(type)
    current_value = hotel['amenities'].try(:[], type) || []
    new_general_amenities = extract_values_from_data(keys.try(:[], type)) do |items|
      items.map do |item|
        item.underscore.humanize.downcase.strip
      end
    end

    current_value.concat(new_general_amenities).uniq
  end
end
