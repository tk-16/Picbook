class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :like_books, through: :likes, source: :book

  
  validates :nickname,presence: true 
  
end
