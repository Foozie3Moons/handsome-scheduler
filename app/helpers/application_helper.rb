module ApplicationHelper
  def is_active? link_path
    request.fullpath == link_path ? "is-active" : ""
  end

  def landing_page?
    request.fullpath == root_path
  end
end
