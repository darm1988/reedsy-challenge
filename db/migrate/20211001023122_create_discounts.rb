class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.references :item
      t.string     :expression

      t.timestamps
    end
  end
end
