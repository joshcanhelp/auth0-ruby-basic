module ApplicationHelper

  # Returns the full title per page
  def meta_title (page_title = '')
    base_title = 'Basic Auth0 Ruby App'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
