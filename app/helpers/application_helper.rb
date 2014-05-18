module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Sollers Consulting Mundial"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  DRAW = 0
  HOME_TEAM_WIN = 1
  AWAY_TEAM_WIN = 2
  
end
