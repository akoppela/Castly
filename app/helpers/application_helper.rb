module ApplicationHelper
  
  STYLES_HASH = { :prerelease => "prerelease.css" }
  
  def styles(type)
    content_for :style do
      stylesheet_link_tag STYLES_HASH[type]
    end
  end
  
end
