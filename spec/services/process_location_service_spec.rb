# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessLocationService, type: :service do
  describe '#process' do
    let(:data) { {} }
    let(:subject) { described_class.new(data, hotel, keys).process }
    let(:new_lat) { 0 }
    let(:new_lng) { 0 }
    let(:new_address) { Faker::Lorem.sentence }
    let(:new_city) { Faker::Lorem.word }
    let(:new_country) { Faker::Lorem.word }
    let(:keys) do
      {
        'lat' => 'Latitude',
        'lng' => 'Longitude',
        'address' => 'Address',
        'city' => 'City',
        'country' => 'Country'
      }
    end

    before do
      allow_any_instance_of(described_class)
        .to receive(:extract_value_from_data)
        .with('Latitude')
        .and_return(new_lat)

      allow_any_instance_of(described_class)
        .to receive(:extract_value_from_data)
        .with('Longitude')
        .and_return(new_lng)

      allow_any_instance_of(described_class)
        .to receive(:extract_value_from_data)
        .with('Address')
        .and_return(new_address)

      allow_any_instance_of(described_class)
        .to receive(:extract_value_from_data)
        .with('City')
        .and_return(new_city)

      allow_any_instance_of(described_class)
        .to receive(:extract_value_from_data)
        .with('Country')
        .and_return(new_country)
    end

    context 'when hotel has location' do
      let(:hotel) { build(:hotel, location: location) }
      let(:location) do
        {
          lat: 0,
          lng: 1,
          address: Faker::Lorem.sentence,
          city: Faker::Lorem.word,
          country: Faker::Lorem.word
        }
      end

      it 'returns current name' do
        expect(subject).to eq location
      end
    end

    context 'when hotel has no name' do
      let(:hotel) { build(:hotel, location: {}) }
      let(:new_location) do
        {
          lat: new_lat,
          lng: new_lng,
          address: new_address,
          city: new_city,
          country: new_country
        }
      end

      it 'returns new location' do
        expect(subject).to eq new_location
      end
    end
  end
end
