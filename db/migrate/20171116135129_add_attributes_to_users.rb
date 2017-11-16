class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :province, :string
    add_column :users, :school, :string
    add_column :users, :username, :string
  end
end
