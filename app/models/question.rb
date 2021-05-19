class Question < ApplicationRecord
    validates :title, presence: true
    validates :prize, presence: true
    validates :response_cost, presence: true
    validates :closing_date_and_time, presence: true
    has_many :comments, dependent: :destroy 
   

    def check_if_active?
        if self.closing_date_and_time < DateTime.now 
            self.active = false 
            self.save
            return false
        else 
            return true 
        end
    end
  
end
