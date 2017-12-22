class ChangeColumnType < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :skill, :text
  	change_column :users, :course_name, :text
  end
end
