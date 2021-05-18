class Comment < ApplicationRecord
  belongs_to :question
  validates :body, presence: true
  has_many :likes

  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end
end
