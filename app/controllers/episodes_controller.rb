class EpisodesController < ApplicationController
  def index
    @episodes = Episode.order(published_at: :desc)
  end

  def show
    @episode = Episode.find(params[:id])
  end

  def toggle_like
  episode = Episode.find(params[:id])
  like = episode.likes.find_by(user: current_user)

  if like
    like.destroy
  else
    episode.likes.create(user: current_user)
  end

  redirect_back fallback_location: root_path
end
end
