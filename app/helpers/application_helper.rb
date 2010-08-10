module ApplicationHelper
  def nav_item(path,title,klass = nil, counter = nil, additional_paths = [])
    additional_paths << path
    active_class =  "current" if additional_paths.map{|v| current_page?(v) }.include?(true)
    result = "<li class='nav-item #{klass} #{active_class}'>"
    common_body = content_tag(:span, title, :class => "text")
    common_body << simple_corners
    common_body << content_tag(:strong, counter, :class => "count") if counter
    result << if additional_paths.map{|v| current_page?(v) }.include?(true)
      common_body
     else
       link_to path do
         common_body
       end
     end
    result <<"</li>"
    raw result
  end
  
  def simple_corners
    '<i class="border-left"></i><i class="border-right"></i><i class="bg"></i>'.html_safe
  end
end
