class AddRentalReturnColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :returned, :timestamps
  end
end
