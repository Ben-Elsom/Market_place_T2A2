class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :username, presence: true, length: { maximum: 100 }
end
