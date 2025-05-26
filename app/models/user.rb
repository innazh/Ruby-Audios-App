class User < ApplicationRecord
    has_many :likes, dependent: :destroy
    has_many :liked_episodes, through: :likes, source: :episode

    validates :email, presence: true, uniqueness: true
end
