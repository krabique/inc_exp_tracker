# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ''
      t.string :type, null: false, default: ''
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
