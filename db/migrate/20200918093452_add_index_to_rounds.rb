class AddIndexToRounds < ActiveRecord::Migration[6.0]
  def change
    add_index :rounds, :round, :unique => true
    #Ex:- add_index("admin_users", "username")
  end
end
