class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  with_options presence: true do
    validates :title
    validates :story
    validates :impression
    validates :image
  end
end
