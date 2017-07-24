class CreateTrackpoints < ActiveRecord::Migration[5.1]
  def change
    create_table :trackpoints do |t|
      t.belongs_to :user, index: true
      t.integer :session, index: true, limit: 8, null: false, default: 0
      t.decimal :latitude, precision: 15, scale: 13, default: 0.0
      t.decimal :longitude, precision: 15, scale: 13, default: 0.0
      t.decimal :altitude, default: 0.0
      t.datetime :created_at, null: false
    end
  end
end
