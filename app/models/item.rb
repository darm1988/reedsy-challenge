class Item < ApplicationRecord
  has_many :discounts

  validates :code, presence: true, uniqueness: true
end
