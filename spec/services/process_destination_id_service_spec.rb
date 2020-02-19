# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessDestinationIdService, type: :service do
  describe '#process' do
    let(:new_destination_id) { Faker::Number.digit }
    let(:data) { {} }
    let(:subject) { described_class.new(data, hotel).process }

    before do
      allow_any_instance_of(described_class)
        .to receive(:extract_value_from_data)
        .with(described_class::KEYS)
        .and_return(new_destination_id)
    end

    context 'when hotel has destination_id' do
      let(:hotel) { build(:hotel, destination_id: destination_id) }
      let(:destination_id) { Faker::Number.digit }

      it 'returns current destination_id' do
        expect(subject).to eq destination_id
      end
    end

    context 'when hotel has no destination_id' do
      let(:hotel) { build(:hotel, destination_id: nil) }

      it 'returns new destination_id' do
        expect(subject).to eq new_destination_id
      end
    end
  end
end
