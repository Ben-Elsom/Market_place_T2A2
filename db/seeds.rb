require "date"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Question.destroy_all

date = DateTime.now - 1.day
date2 = DateTime.now + 2.day
date3 = DateTime.now + 3.day
date4 = DateTime.now + 4.day
date5 = DateTime.now + 5.day
date6 = DateTime.now + 6.day

user = User.create(email: "a@a.com", password: "123456")

question1 = Question.create(title:"What should I call my speedy flower delivery service?", description: "So the idea is that you will request flowers to be sent to an address and we will deliver the flowers within the hour with your custom message.", prize: 50, response_cost: 0.10, closing_date_and_time: date, user: user)

Comment.create(body: "I think you should call it 'fast flowers'", question: question1)
Comment.create(body: "'Real quick roses'", question: question1)
Comment.create(body: "'Speedy spuds'", question: question1)

question2 = Question.create(title:"What should I do for a hobby", description: " I am a 19 year old boy who has too much free time and want to know what would be the best hobby for me to get into. I want to impress girls and hopefully be able to earn money off of it one day. ", prize: 10, response_cost: 0.10, closing_date_and_time: date2, user: user)

Comment.create(body: "Rock Climbing'", question: question2)
Comment.create(body: "'Memes lol'", question: question2)
Comment.create(body: "'Guitar'", question: question2)

question3 = Question.create(title:"What is your best pick up line", prize: 10, response_cost: 0.10, closing_date_and_time: date3, user: user)

Comment.create(body: "Did it hurt? When you fell form heaven'", question: question3)
Comment.create(body: "Baby you're the CSS to my HTML.", question: question3)
Comment.create(body: "My servers never go down... but I do.", question: question3)

question4 = Question.create(title:"How do I tell my parents i'm gay", description: "So I am a guy and have know i'm homosexual for about two years now. I started dating this guy (Tom) a couple months ago and really want my parents to meet him but they don't know i'm gay yet. Help please", prize: 100, response_cost: 10.10, closing_date_and_time: date4, user: user)

Comment.create(body: "Stop overthinking it an just tell them. You'll still be their son and there's nothing they can do about it", question: question4)
Comment.create(body: "Tell them fake bad news and then say 'just kidding... I'm gay'", question: question4)
Comment.create(body: "Bring your boyfriend over and they'll figure it out", question: question4)

question5 = Question.create(title:"What is your best piece of advice", description: "feeling bored and have got $20 burning a hole in my pocket. What's your best piece of life advice?", prize: 100, response_cost: 10.10, closing_date_and_time: date5, user: user)

Comment.create(body: "YOLO", question: question5)
Comment.create(body: "Don't overthink it. You'll be fine... or you'll be dead and won't have to worry about it", question: question5)
Comment.create(body: "Vote, it makes the world a better place", question: question5)

question6 = Question.create(title:"What should I name my child?", description: "My husband and I have just found out we are expecting a baby in August of this year. What are you best name suggestions?", prize: 50, response_cost: 5.0, closing_date_and_time: date6, user: user)

Comment.create(body: "BabyMcBabyface", question: question6)
Comment.create(body: "Chelsey, I think it's beautiful name and is timeless", question: question6)
Comment.create(body: "Droptable", question: question6)
Comment.create(body: "Latten", question: question6)
Comment.create(body: "Clementine", question: question6)
Comment.create(body: "Sulivan", question: question6)
Comment.create(body: "Liam", question: question6)
Comment.create(body: "Gus", question: question6)
Comment.create(body: "Glen", question: question6)
Comment.create(body: "Sarah", question: question6)
Comment.create(body: "Matt", question: question6)
Comment.create(body: "Persia", question: question6)
Comment.create(body: "Doug", question: question6)
Comment.create(body: "Ewan", question: question6)