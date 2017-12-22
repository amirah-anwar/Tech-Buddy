class CreateBuddyships < ActiveRecord::Migration[5.0]
  def change
    create_table :buddyships do |t|
      t.integer :user_id
      t.integer :buddy_id
      t.string :create
      t.string :destroy

      t.timestamps
    end
  end
end
