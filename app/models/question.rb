

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
    validate :valid_date?, :unless => :exists?


    def exists?
        !self.id.nil?
    end

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

    def valid_date?
        if self.closing_date_and_time > DateTime.now
            return true 
        else
            errors.add(:closing_date_and_time, "must be after current time")
        end
    end
  
end
