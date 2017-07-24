class AddSpeedDirectionNameToTrackPoint < ActiveRecord::Migration[5.1]
  def change
    add_column :trackpoints, :speed, :decimal, default: 0.0
    add_column :trackpoints, :direction, :decimal, default: 0.0
    add_column :trackpoints, :name, :string, default: ""
  end
end
