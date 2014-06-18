class AddRevisedToPages < ActiveRecord::Migration
  def change
    add_column :pages, :revised, :boolean, default: false
  end
end
