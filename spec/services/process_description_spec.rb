# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessDescriptionService, type: :service do
  describe '#process' do
    let(:new_description) { Faker::Lorem.sentence }
    let(:data) { {} }
    let(:subject) { described_class.new(data, hotel).process }

    before do
      allow_any_instance_of(described_class)
        .to receive(:extract_value_from_data)
        .with(described_class::KEYS)
        .and_return(new_description)
    end

    context 'when hotel has description' do
      let(:hotel) { build(:hotel, description: description) }
      let(:description) { Faker::Lorem.sentence }

      it 'returns current description' do
        expect(subject).to eq description
      end
    end

    context 'when hotel has no description' do
      let(:hotel) { build(:hotel, description: nil) }

      it 'returns new description' do
        expect(subject).to eq new_description
      end
    end
  end
end
