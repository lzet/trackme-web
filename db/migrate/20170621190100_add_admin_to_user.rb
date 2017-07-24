class AddAdminToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :disabled, :boolean, default: false
    add_column :users, :canmodify, :boolean, default: true
    add_index :trackpoints, :name
  end
end
