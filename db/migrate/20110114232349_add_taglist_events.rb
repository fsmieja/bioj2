class AddTaglistEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :taglist, :text
  end

  def self.down
    remove_column :events, :taglist
  end
end
