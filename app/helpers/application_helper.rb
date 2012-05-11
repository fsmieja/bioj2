# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def logo
    image_tag("stlogo2.jpg", :alt => "SmartaTech - Biojotter", :class => "round",  :size => "200x65")
  end

end
