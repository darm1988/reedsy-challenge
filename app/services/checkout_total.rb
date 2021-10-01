class CheckoutTotal

  def initialize(items)
    @items = items
  end

  def execute
    total = 0
    @items.each do |item_code, qty|
      item = Item.find_by_code(item_code)
      if item.present?
        total += item.price * qty
        # calculate discount if any
        discount = 0
        item.discounts.each do |d|
          discount += d.apply(qty)
        end

        total -= discount
      end
    end

    total
  end
end
