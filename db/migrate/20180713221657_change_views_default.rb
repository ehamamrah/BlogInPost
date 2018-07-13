class ChangeViewsDefault < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :views, :integer, default: 0
  end
end
