class RemoveTaglist < ActiveRecord::Migration
  def self.up
    remove_column :events, :taglist
  end

  def self.down
    add_column :events, :taglist, :text
  end
end
