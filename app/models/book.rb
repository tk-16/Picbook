class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user


  validates :title, presence: true
  validates :story, presence: true
  validates :impression, presence: true
end
