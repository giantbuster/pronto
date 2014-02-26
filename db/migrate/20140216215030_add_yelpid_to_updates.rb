class AddYelpidToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :yelp_id, :string
  end
end
