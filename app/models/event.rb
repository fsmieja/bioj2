class Event < ActiveRecord::Base
  attr_accessible :title, :summary, :content, :date

  has_and_belongs_to_many :tags

  validates :title, :presence => true, :length => { :maximum => 50 }
  validates :summary, :presence => true
  validates :content, :presence => true

  default_scope :order => 'events.date DESC'

  def self.get_tags(taglist)
    return taglist.split(/%w/)
  end

  def self.disconnect_old_tags(event_id,newtagnames)
    event = Event.find(event_id)
    deletelist = Array.new
    allmytags = event.tags
    allmytags.each do |ta|
      puts 'checking '+ta.name
      if newtagnames.size==0 || !newtagnames.include?(ta.name)     # no longer have it
        deletelist << ta
      end
    end
    deletelist.each do |ta|
      event.tags.delete(ta)                            # remove the connection     
      event.save
      Tag.get_count(ta)
      puts ' removed'+ta.name
    end
  end

end
