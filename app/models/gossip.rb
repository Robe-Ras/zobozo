class Gossip < ApplicationRecord
  has_many :gossip_tags
  has_many :tags, through: :gossip_tags
  has_many :like_gossips
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, length: {in: 3..14}
  validates :content, presence: true
  
  def image_url
    "https://source.unsplash.com/random/300x200?person&sig=#{self.id}"
  end
end

