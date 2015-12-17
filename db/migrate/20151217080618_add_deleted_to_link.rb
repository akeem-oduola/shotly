class AddDeletedToLink < ActiveRecord::Migration
  def change
    add_column :links, :deleted, :boolean, default: true
  end
end
