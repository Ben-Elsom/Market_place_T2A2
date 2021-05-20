

class Question < ApplicationRecord
    validates :title, presence: true
    validates :prize, presence: true
    validates :response_cost, presence: true
    validates :closing_date_and_time, presence: true
    has_many :comments, dependent: :destroy 
    has_one_attached :explaination_photo 
    belongs_to :user
    validate :has_enough_funds?

    def check_if_active?
        if self.closing_date_and_time < DateTime.now 
            self.active = false 
            self.save
            return false
        else 
            return true 
        end
    end

    def has_enough_funds?
        errors.add(:prize, "can not be greater than your account balance") if user.balance < prize
    end
  
end
