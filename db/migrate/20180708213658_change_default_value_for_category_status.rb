class ChangeDefaultValueForCategoryStatus < ActiveRecord::Migration[5.1]
  def change
    change_column :categories, :status, :integer, default: CATEGORIES_STATUS[:active]
  end
end
