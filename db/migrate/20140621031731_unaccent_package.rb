class UnaccentPackage < ActiveRecord::Migration
  def up
    #not compatible with sqlite3
    #execute "CREATE EXTENSION unaccent;"
  end

  def down
    #not compatible with sqlite3
    #execute "DROP EXTENSION unaccent;"
  end
end
