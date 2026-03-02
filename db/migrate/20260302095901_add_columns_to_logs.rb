class AddColumnsToLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :logs, :title, :string
    add_column :logs, :design, :text
    add_column :logs, :study, :text
    add_column :logs, :implementation, :text
  end
end
