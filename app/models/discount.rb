class Discount < ApplicationRecord
  belongs_to :item

  def apply(item_number)
    lambda_exp = Base64.decode64(self.expression)
    return (eval lambda_exp).call(item_number, self.item.price)
  end
end
