class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments


  validates :title, presence: true
  validates :story, presence: true
  validates :impression, presence: true
end
