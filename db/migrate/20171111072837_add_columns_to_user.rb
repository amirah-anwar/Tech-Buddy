class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :status, :string
    add_column :users, :recomendation, :text
    add_column :users, :skill, :string
    add_column :users, :course_code, :string
    add_column :users, :course_name, :string
    add_column :users, :major, :string
    add_column :users, :education_level, :string
    add_column :users, :current_buddy, :integer
    add_column :users, :goal, :text
  end
end
