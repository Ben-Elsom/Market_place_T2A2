class Question < ApplicationRecord
    validates :title, presence: true
    validates :prize, presence: true
    validates :response_cost, presence: true
end
