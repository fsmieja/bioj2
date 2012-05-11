class AddTagCount < ActiveRecord::Migration
  def self.up
    add_column :tags, :count, :integer    
  end

  def self.down
    remove_column :tags, :count
  end
end
