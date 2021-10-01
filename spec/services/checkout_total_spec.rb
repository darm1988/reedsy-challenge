require 'rails_helper'

RSpec.describe CheckoutTotal do
  let(:items) {
    { 'MUG': 4, 'TSHIRT': 3, 'UNKNOWN': 1 }
  }
  subject { described_class.new(items) }

  before do
    Item.destroy_all
    @mug = FactoryBot.create(:item)
    @tshirt = FactoryBot.create(:item, code: 'TSHIRT', name: 'Reedsy T-Shirt', price: 15)
  end

  describe '#execute' do
    context 'no discounts' do
      it 'calculates the total' do
        expect(subject.execute).to eq(69)
      end
    end

    context 'items have discounts' do
      before do
        Discount.destroy_all
        # 2-for-1 discount
        mug_discount = Base64.encode64('
          lambda { |item_number, item_price| 
            (item_number >= 2 ? item_price : 0)
          }
        ')
        @mug.discounts.create(expression: mug_discount)

        # 30% on all tshirts
        tshirt_discount = Base64.encode64('
          lambda { |item_number, item_price|
            (item_number >= 3 ? (item_number * item_price * 0.3) : 0)
          }
        ')
        @tshirt.discounts.create(expression: tshirt_discount)
      end

      it 'calculates the total' do
        expect(subject.execute).to eq(49.5)
      end
    end
  end
end
