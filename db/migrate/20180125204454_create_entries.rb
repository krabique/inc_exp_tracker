# frozen_string_literal: true

class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.monetize :amount
      t.text :comment

      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
