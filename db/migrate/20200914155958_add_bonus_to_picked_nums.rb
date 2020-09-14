class AddBonusToPickedNums < ActiveRecord::Migration[6.0]
  def change
    add_column :picked_nums, :bonus, :boolean, default: false
  end
end
