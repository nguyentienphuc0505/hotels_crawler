# frozen_string_literal: true

class ProcessLocationService < BaseService
  LATTITUDE_KEYS = %w[Latitude lat].freeze
  LONGTITUDE_KEYS = %w[Longitude lng].freeze
  ADDRESS_KEYS = ['Address', 'address', 'location.address'].freeze
  CITY_KEYS = ['City'].freeze
  COUNTRY_KEYS = ['location.country', 'Country'].freeze

  def process
    {
      lat: process_lat,
      lng: process_lng,
      address: process_adress,
      city: process_city,
      country: process_country
    }
  end

  private

  def process_lat
    hotel.location['lat'] || extract_value_from_data(LATTITUDE_KEYS)
  end

  def process_lng
    hotel.location['lng'] || extract_value_from_data(LONGTITUDE_KEYS)
  end

  def process_adress
    hotel.location['address'] || extract_value_from_data(ADDRESS_KEYS, &:strip)
  end

  def process_city
    hotel.location['city'] || extract_value_from_data(CITY_KEYS)
  end

  def process_country
    hotel.location['country'] || extract_value_from_data(COUNTRY_KEYS)
  end
end
