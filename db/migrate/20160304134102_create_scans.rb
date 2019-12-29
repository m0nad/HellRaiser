class CreateScans < ActiveRecord::Migration[5.0]
  def change
    create_table :scans do |t|
      t.string  :title,   null: false
      t.string  :target,  null: false
      t.integer :status,  null: false, default: 0
      t.string  :jid,     null: true

      t.timestamps null: false
    end
  end
end
