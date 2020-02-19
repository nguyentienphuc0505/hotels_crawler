# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessImagesService, type: :service do
  describe '#process' do
    context 'when hotel has images' do
      let(:image) { { link: 'link', description: 'description' } }
      let(:new_image) { { link: 'link_2', caption: 'description_2' } }
      let(:hotel) { build :hotel, images: { rooms: [image] } }
      let(:data) { {} }
      let(:subject) { described_class.new(data, hotel).process }

      before do
        allow_any_instance_of(described_class).to receive(:extract_values_from_data).and_return([new_image])
      end

      it 'merges new image to db base on type' do
        expect(subject[:rooms].count).to eq 2
      end
    end
  end
end
