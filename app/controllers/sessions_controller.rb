require 'services/github'

class SessionsController < ApplicationController
  def create
    user_data = Services::Github.get_user_data(params[:github_access_token])
    user = User.find_by_github_id(user_data[:id])

    if !user
      user = User.create!(github_id: user_data[:id], github_login: user_data[:login], email: user_data[:email])
    end

    session[:user_id] = user.id

    render json: user
  end
end
