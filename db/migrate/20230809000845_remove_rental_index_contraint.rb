class RemoveRentalIndexContraint < ActiveRecord::Migration[7.0]
  def change
    remove_index :rentals, [:user_id, :movie_id], unique: true
  end
end
