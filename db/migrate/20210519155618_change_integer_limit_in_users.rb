class ChangeIntegerLimitInUsers < ActiveRecord::Migration[6.1]
  def change
  	change_column :users, :contact_no, :integer, limit: 8
  end
end
