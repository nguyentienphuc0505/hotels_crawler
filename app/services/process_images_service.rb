# frozen_string_literal: true

class ProcessImagesService < BaseService
  def process
    {
      rooms: process_images_for('rooms'),
      site: process_images_for('site'),
      amenities: process_images_for('amenities')
    }
  end

  private

  def process_images_for(type)
    current_images = hotel.images[type] || []
    new_images = extract_values_from_data(keys.try(:[], type)) do |items|
      items.map do |item|
        {
          link: extract_value_from_data(keys['item'].try(:[], 'link'), item),
          description: extract_value_from_data(keys['item'].try(:[], 'description'), item)
        }
      end
    end

    current_images.concat(new_images).uniq { |i| i['link'] }
  end
end
