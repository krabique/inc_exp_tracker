# frozen_string_literal: true

class UpdateForeignKeys < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :entries, :users
    remove_foreign_key :entries, :categories
    remove_foreign_key :categories, :users

    add_foreign_key :entries, :users, on_delete: :cascade
    add_foreign_key :entries, :categories, on_delete: :cascade
    add_foreign_key :categories, :users, on_delete: :cascade
  end
end
