class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :website, :string
    add_column :users, :location, :string
    add_column :users, :realname, :string
    add_column :users, :aboutme, :text
  end
end
