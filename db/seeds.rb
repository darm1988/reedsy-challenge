# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

mug = Item.create(code: 'MUG', name: 'Reedsy Mug', price: 6)
tshirt = Item.create(code: 'TSHIRT', name: 'Reedsy T-shirt', price: 15)
hoodie = Item.create(code: 'HOODIE', name: 'Reedsy Hoodie', price: 20)

# 2-for-1 discount
mug_discount = Base64.encode64('
  lambda { |item_number, item_price| 
    (item_number >= 2 ? item_price : 0)
  }
')
mug.discounts.create(expression: mug_discount)

# 30% on all tshirts
tshirt_discount = Base64.encode64('
  lambda { |item_number, item_price|
  (item_number >= 3 ? (item_number * item_price * 0.3) : 0)
  }
')
tshirt.discounts.create(expression: tshirt_discount)
