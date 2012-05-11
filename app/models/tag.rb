class Tag < ActiveRecord::Base
  has_and_belongs_to_many :events
  validates :name, :length => { :minimum => 2, :maximum => 8 }

  def self.add_new_tags(event_id,tagarray)
    if tagarray.size==0
      return
    end
    event = Event.find(event_id)
    tagarray.each do |ta|
      tag = Tag.find_by_name(ta)   # do we already have this tag?
      if tag.blank?
        tag = Tag.new(:name => ta) # no, so create it
        tag.save
      end
      
      eventtags = Tag.find(:all, :joins => :events, 
                      :conditions => {:events => {:id => event_id}, :tags => {:id => tag.id}})
      if eventtags.blank?
        event.tags << tag          # event is not connected to it, so make that connection
        event.save
	Tag.get_count(tag)
      end
    end
  end


  def self.get_count(tag)
    tag.count = tag.events.size
    tag.save
  end

  def self.remove_tags(event_id)
    event = Event.find(event_id)
    eventtags = event.tags
    eventtags.delete_all
    eventtags.each do |e|
      e.delete
    end
  end

  def self.housekeep
    alltags = Tag.find(:all)
    alltags.each do |t|
      orphans = Tag.find(:all, :joins => :events, 
                   :conditions => {:tags => {:id => t.id}})
      if orphans.blank?
        puts 'found an orphan tag: '+t.name+' - deleting'
        t.delete
      end
    end  
  end
end
