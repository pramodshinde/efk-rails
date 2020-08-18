class SyncController < ApplicationController

  def index
    render json: User.all.as_json({only: [:username]})
  end

  def create
    User.create!(user_params)
    head :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :mobile)
  end
end
