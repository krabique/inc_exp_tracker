class ModifyEntries < ActiveRecord::Migration[5.1]
  def change
    change_column :entries, :user_id, :bigint, null: false
    change_column :entries, :category_id, :bigint, null: false
  end
end
