class AddForeignKeyToPickedNumsRound < ActiveRecord::Migration[6.0]
  def up
    change_column :picked_nums, :round, :bigint, null: false
  end

  def down
    change_column :picked_nums, :round, :int
  end
end
