class EpisodesController < ApplicationController
  def index
    tag = params[:tag]
    @episodes = Episode.order(published_at: :desc)
    if tag.present?
      @episodes = @episodes.select do |episode|
        episode.tags.any? { |t| t.name == tag }
      end
    end
  end

  def show
    @episode = Episode.find(params[:id])
    @tags = @episode.tags
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
