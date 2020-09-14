class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.integer :round, null: false
      t.date :draw, null: false

      t.timestamps
    end
  end
end
