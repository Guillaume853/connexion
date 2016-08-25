class AddLunchesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lunch, :boolean
    add_column :users, :after, :boolean
  end
end
