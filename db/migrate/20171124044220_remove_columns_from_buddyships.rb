class RemoveColumnsFromBuddyships < ActiveRecord::Migration[5.0]
  def change
  	remove_column :buddyships, :create
  	remove_column :buddyships, :destroy
  end
end
