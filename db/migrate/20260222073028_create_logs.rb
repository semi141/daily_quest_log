class CreateLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :logs do |t|
      t.text :content
      t.integer :duration
      t.string :category
      t.text :memo
      t.date :log_date

      t.timestamps
    end
  end
end
