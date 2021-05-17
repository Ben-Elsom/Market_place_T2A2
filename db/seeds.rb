require "date"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Comment.destroy_all
Question.destroy_all
date = DateTime.now + 1.day

question1 = Question.create(title:"What should I call my speedy flower delivery service?", description: "So the idea is that you will request flowers to be sent to an address and we will deliver the flowers within the hour with your custom message.", prize: 50, response_cost: 0.10, closing_date_and_time: date)

Comment.create(body: "I think you should call it 'fast flowers'", question: question1)
