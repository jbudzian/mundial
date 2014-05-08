module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, imgsize = 80)
    raise "User is nil" if user.nil?
    image_tag user.gravatar_url(
          :default => "http://png.findicons.com/files/icons/175/halloween_avatar/#{imgsize}/alien.png",
          :size => imgsize), alt: user.name, class: "gravatar"
  end
end
