class AddAttributesToClick < ActiveRecord::Migration
  def change
    add_column :clicks, :ip, :inet
    add_column :clicks, :country, :string
  end
end
