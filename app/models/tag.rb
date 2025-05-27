class Tag < ApplicationRecord
    has_many :episode_tags, dependent: :destroy
end
