class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.references :link, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
