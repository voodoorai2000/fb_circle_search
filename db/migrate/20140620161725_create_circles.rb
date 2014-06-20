class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :name
      t.string :fb_id
      t.string :kind
      t.boolean :revised, default: false

      t.timestamps
    end
  end
end
