# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessAmenitiesService, type: :service do
  describe '#process' do
    let(:new_general_amenities) { %w[a b] }
    let(:new_room_amenities) { %w[c d e] }
    let(:data) { {} }
    let(:hotel) { build(:hotel) }
    let(:subject) { described_class.new(data, hotel).process }

    before do
      allow_any_instance_of(described_class)
        .to receive(:extract_values_from_data)
        .with(described_class::GENERAL_KEYS)
        .and_return(new_general_amenities)

      allow_any_instance_of(described_class)
        .to receive(:extract_values_from_data)
        .with(described_class::ROOM_KEYS)
        .and_return(new_room_amenities)
    end

    context 'when hotel has description' do
      it 'returns new merged data ' do
        expect(subject[:general]).to match_array new_general_amenities
        expect(subject[:room]).to match_array new_room_amenities
      end
    end
  end
end
