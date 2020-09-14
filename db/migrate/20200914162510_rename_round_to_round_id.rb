class RenameRoundToRoundId < ActiveRecord::Migration[6.0]
  def change
    rename_column :picked_nums, :round, :round_id
  end
end
