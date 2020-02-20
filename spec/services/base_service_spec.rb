# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseService, type: :service do
  describe '#extract_value_from_data' do
    let(:subject) { described_class.new(source, nil, nil).extract_value_from_data(keys) }

    context 'extract data for source 1' do
      let(:source) do
        JSON.parse(File.read(Rails.root.join('spec/support/source_1.json'))).first
      end

      context 'extract name' do
        let(:keys) { 'Name' }

        it 'returns correct value' do
          expect(subject).to eq 'Beach Villas Singapore'
        end
      end

      context 'extract destination id' do
        let(:keys) { 'DestinationId' }

        it 'returns correct value' do
          expect(subject).to eq 5432
        end
      end

      context 'extract booking conditions' do
        let(:keys) { 'Description' }

        it 'returns correct value' do
          expect(subject).to eq '  This 5 star hotel is located on the coastline of Singapore.'
        end
      end

      context 'extract lat' do
        let(:keys) { 'Latitude' }

        it 'returns correct value' do
          expect(subject).to eq 1.264751
        end
      end

      context 'extract address' do
        let(:keys) { 'Address' }

        it 'returns correct value' do
          expect(subject).to eq ' 8 Sentosa Gateway, Beach Villas '
        end
      end
    end

    context 'extract data for source 2' do
      let(:source) do
        JSON.parse(File.read(Rails.root.join('spec/support/source_2.json'))).first
      end

      context 'extract name' do
        let(:keys) { 'hotel_name' }

        it 'returns correct value' do
          expect(subject).to eq 'Beach Villas Singapore'
        end
      end

      context 'extract destination id' do
        let(:keys) { 'destination_id' }

        it 'returns correct value' do
          expect(subject).to eq 5432
        end
      end

      context 'extract description' do
        let(:keys) { 'details' }

        it 'returns correct value' do
          expect(subject).to eq 'Surrounded by tropical gardens, these upscale villas in elegant '\
          'Colonial-style buildings are part of the Resorts World Sentosa complex and a 2-minute walk '\
          'from the Waterfront train station. Featuring sundecks and pool, garden or sea views, '\
          'the plush 1- to 3-bedroom villas offer free Wi-Fi and flat-screens, as well as '\
          'free-standing baths, minibars, and tea and coffeemaking facilities. Upgraded villas '\
          'add private pools, fridges and microwaves; some have wine cellars. A 4-bedroom unit '\
          "offers a kitchen and a living room. There's 24-hour room and butler service. "\
          'Amenities include posh restaurant, plus an outdoor pool, a hot tub, and free parking.'
        end
      end

      context 'extract address' do
        let(:keys) { 'location.address' }

        it 'returns correct value' do
          expect(subject).to eq '8 Sentosa Gateway, Beach Villas, 098269'
        end
      end
    end

    context 'extract data for source 3' do
      let(:source) do
        JSON.parse(File.read(Rails.root.join('spec/support/source_3.json'))).first
      end

      context 'extract name' do
        let(:keys) { 'name' }

        it 'returns correct value' do
          expect(subject).to eq 'Beach Villas Singapore'
        end
      end

      context 'extract destination id' do
        let(:keys) { 'destination' }

        it 'returns correct value' do
          expect(subject).to eq 5432
        end
      end

      context 'extract address' do
        let(:keys) { 'address' }

        it 'returns correct value' do
          expect(subject).to eq '8 Sentosa Gateway, Beach Villas, 098269'
        end
      end
    end
  end

  describe '#extract_values_from_data' do
    let(:subject) { described_class.new(source, nil, nil).extract_values_from_data(keys) }

    context 'extract data for source 1' do
      let(:source) do
        JSON.parse(File.read(Rails.root.join('spec/support/source_1.json'))).first
      end

      context 'extract booking conditions' do
        let(:keys) { 'booking_conditions' }

        it 'returns correct value' do
          expect(subject.count).to eq 0
        end
      end

      context 'extract amenities' do
        let(:keys) { 'Facilities' }

        it 'returns correct value' do
          expect(subject).to match_array ['Pool', 'BusinessCenter', 'WiFi ', 'DryCleaning', ' Breakfast']
        end
      end
    end

    context 'extract data for source 2' do
      let(:source) do
        JSON.parse(File.read(Rails.root.join('spec/support/source_2.json'))).first
      end

      context 'extract booking conditions' do
        let(:keys) { 'booking_conditions' }

        it 'returns correct value' do
          expect(subject.count).to eq 5
        end
      end
    end

    context 'extract data for source 3' do
      let(:source) do
        JSON.parse(File.read(Rails.root.join('spec/support/source_2.json'))).first
      end

      context 'extract booking conditions' do
        let(:keys) { 'booking_conditions' }

        it 'returns correct value' do
          expect(subject.count).to eq 5
        end
      end
    end
  end
end
