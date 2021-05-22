

class Question < ApplicationRecord
    validates :title, presence: true
    validates :prize, presence: true
    validates :response_cost, presence: true
    validates :closing_date_and_time, presence: true
    has_many :comments, dependent: :destroy 
    has_one_attached :explaination_photo 
    belongs_to :user
    validate :has_enough_funds?
    validate :date_is_in_future?


    def check_if_active?
        if self.closing_date_and_time < DateTime.now 
            return false
        else 
            return true 
        end
    end

    def has_enough_funds?
        if self.id
            return true
        else 
            errors.add(:prize, "can not be greater than your account balance") if user.balance < prize
        end
    end

    def date_is_in_future?
        if self.closing_date_and_time > DateTime.now
            return true 
        else 
            errors.add(:closing_date_and_time, "must be after current time")
        end
    end
  
end
