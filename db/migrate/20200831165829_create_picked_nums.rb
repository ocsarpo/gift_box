class CreatePickedNums < ActiveRecord::Migration[6.0]
  def change
    create_table :picked_nums do |t|
      t.references :lotto_number, null: false, foreign_key: true
      t.integer :round, null: false

      t.timestamps
    end
  end
end