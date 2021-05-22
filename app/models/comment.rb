class Comment < ApplicationRecord
  belongs_to :question
  validates :body, presence: true
  has_many :likes, dependent: :destroy
  belongs_to :user
  validate :has_enough_funds?
  

  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end

  def has_enough_funds?
    errors.add(:base, "You don't have enough money to make a response") if user.balance < question.response_cost
  end
end
