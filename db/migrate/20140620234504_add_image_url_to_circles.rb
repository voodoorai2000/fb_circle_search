class AddImageUrlToCircles < ActiveRecord::Migration
  def change
    add_column :circles, :image_url, :string
  end
end
