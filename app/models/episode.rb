class Episode < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :title, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :audio_url, presence: true, format: { with: URI::regexp(%w[http https]) }
end