class AddContitutedAtToCircles < ActiveRecord::Migration
  def change
    add_column :circles, :constituted_at, :datetime
  end
end
