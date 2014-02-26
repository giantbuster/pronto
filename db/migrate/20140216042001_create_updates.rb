class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :status
      t.references :user, index: true
      t.references :restaurant, index: true

      t.timestamps
    end
  end
end
