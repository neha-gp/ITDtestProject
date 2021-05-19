class AddContactNoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :contact_no, :integer
  end
end
