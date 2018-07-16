# UsersHelper - helpful functions for getting user data.
module UsersHelper
  def gravatar_for(user, options = { size: 100 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def get_username(user_id)
    User.find_by(id: user_id).name
  end
end
