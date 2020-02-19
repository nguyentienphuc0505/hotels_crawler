# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessNameService, type: :service do
  describe '#process' do
    let(:new_name) { Faker::Lorem.word }
    let(:data) { {} }
    let(:subject) { described_class.new(data, hotel).process }

    before do
      allow_any_instance_of(described_class)
        .to receive(:extract_value_from_data)
        .with(described_class::KEYS)
        .and_return(new_name)
    end

    context 'when hotel has name' do
      let(:hotel) { build(:hotel, name: name) }
      let(:name) { Faker::Lorem.word }

      it 'returns current name' do
        expect(subject).to eq name
      end
    end

    context 'when hotel has no name' do
      let(:hotel) { build(:hotel, name: nil) }

      it 'returns new name' do
        expect(subject).to eq new_name
      end
    end
  end
end
