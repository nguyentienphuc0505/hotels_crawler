# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessBookingConditionsService, type: :service do
  describe '#process' do
    let(:new_booking_conditions) { %w[1 2] }
    let(:data) { {} }
    let(:keys) { 'booking_condition' }
    let(:subject) { described_class.new(data, hotel, keys).process }

    before do
      allow_any_instance_of(described_class)
        .to receive(:extract_values_from_data)
        .with(keys)
        .and_return(new_booking_conditions)
    end

    context 'when hotel has description' do
      let(:hotel) { build(:hotel, booking_conditions: %w[1 3 4]) }

      it 'returns new merged data ' do
        expect(subject).to match_array %w[1 2 3 4]
      end
    end
  end
end
