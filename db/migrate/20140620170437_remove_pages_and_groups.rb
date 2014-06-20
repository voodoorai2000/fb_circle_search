class RemovePagesAndGroups < ActiveRecord::Migration
  def change
    drop_table :groups
    drop_table :pages
  end
end
