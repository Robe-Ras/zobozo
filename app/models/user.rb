require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"
  belongs_to :city
  has_many :gossips
  has_many :comments
  has_many :like_gossips
  has_many :like_comments

  validates :first_name, :last_name, presence: true  
  validates :email, presence: true
  validates :city, presence: true  
end
