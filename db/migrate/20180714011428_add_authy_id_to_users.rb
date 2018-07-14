class AddAuthyIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authy_id, :string
    add_column :users, :authy_enabled, :boolean, default: false
  end
end
