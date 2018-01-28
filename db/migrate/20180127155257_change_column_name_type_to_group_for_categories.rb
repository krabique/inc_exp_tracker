# frozen_string_literal: true

class ChangeColumnNameTypeToGroupForCategories < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :type, :group
  end
end
