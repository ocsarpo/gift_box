class CreateLottoNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :lotto_numbers do |t|
      t.integer :num, null: false, unique: true
      t.string :name, null: false
      t.integer :picked_nums_count, default: 0, unsigned: true

      t.timestamps
    end

    add_index :lotto_numbers, :num, unique: true
  end
end