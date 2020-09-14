class AddFkToPickedNums < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :picked_nums, :rounds
  end
end
