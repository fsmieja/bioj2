class CreateTagTable < ActiveRecord::Migration
  def self.up
      create_table :events_tags, :id => false do |t|
        t.integer :event_id
	t.integer :tag_id

      end

      add_index :events_tags, [:event_id, :tag_id], :unique => true
      add_index :events_tags, :event_id, :unique => false
  end


  def self.down
    remove_table :events_tags
  end
end
