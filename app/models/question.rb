

class Question < ApplicationRecord
    validates :title, presence: true, length: { maximum: 100 }
    validates :prize, presence: true, numericality: { greater_than_or_equal_to: 20 }
    validates :response_cost, presence: true, numericality: { greater_than_or_equal_to: 5 }
    validates :closing_date_and_time, presence: true
    validates :description, length: { maximum: 500 }
    has_many :comments, dependent: :destroy 
    has_one_attached :explaination_photo 
    belongs_to :user
    validate :has_enough_funds?
    validate :date_is_in_future?, :unless => :exists?
    has_one :most_recent_win


    def exists?
        !self.id.nil?
    end

    def is_active?
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

    def needs_tie_breaker?
        if self.active == false && self.prize_given == false 
            return true
        else 
            return false
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
