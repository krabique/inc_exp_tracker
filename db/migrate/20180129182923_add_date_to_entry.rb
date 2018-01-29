# frozen_string_literal: true

class AddDateToEntry < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :date, :datetime, null: false, default: Time.new
  end
end
