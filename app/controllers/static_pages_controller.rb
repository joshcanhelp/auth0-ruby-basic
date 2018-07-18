# StaticPagesController - static pages controller.
class StaticPagesController < ApplicationController
  def home
    render 'home'
  end
  def lock
    @client_id = ENV['AUTH0_RUBY_CLIENT_ID']
    @domain = ENV['AUTH0_RUBY_DOMAIN']
    # see SessionsHelper::get_state
    @state = get_state
    render 'lock'
  end
end
