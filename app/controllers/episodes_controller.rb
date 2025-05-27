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

  def new
    @episode = Episode.new
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

  def create
    @episode = Episode.new(episode_params.merge(published_at: Date.today))
    if @episode.save
      tag_names = params[:tag_list].to_s.split(',').map(&:strip).reject(&:blank?)
      tag_names.each do |name|
        tag = Tag.find_or_create_by(name: name)
        @episode.tags << tag unless @episode.tags.include?(tag)
      end

      redirect_to root_path, notice: 'Episode created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def episode_params
    params.require(:episode).permit(:title, :description, :duration, :audio_url)
  end
end
