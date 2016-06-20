class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.string :title
      t.string :target
      t.integer :status

      t.timestamps null: false
    end
  end
end
