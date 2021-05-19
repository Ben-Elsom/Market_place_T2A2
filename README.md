I would like to make an app where users can post questions and other users can give responses to that question. It costs $2 to post a question and 10c to post a comment. 

The $2 (minimum) for creating the question and the 10c for adding a comment will be added to a pool of money for that question.
At the end of a set period of time the question will close and the most liked comment will receive the pool of money that has been collected for the question. 

When starting a question I would like for the user to choose how high the entry for the response should be (from 10c to say $5 depending on how complex the of an answer they are expecting). They should also be able to set how much of a prize/price they would like to set on this question (higher would obviously attract more responses) 


#### Problem being solved
Coming up with ideas is hard. There are casual services that can help people generate ideas but they are either not specific enough (name generators) or have lots of low quality answers (Ask reddit, Instagram polls).

My app “Idea Lab” is a brainstorming website with prizes for the best ideas and barriers to entry for responses so that only ideas that creators believe are decent will be posted. This will allow for a better idea generating service then anything that is currently available on the internet. 

#### Why is it a problem
I believe there will be a lot of people who were in my position when I was trying to decide what app to build and need a more solid way to generate ideas for anything from what they should do for a hobby to where they should eat tonight.

Alternatively, it could be used for more professional uses like what product people would like to see from company xyz or what their pet peeve with company xyz is or that company’s competition.

#### Link to website 



#### link to github 


#### description of market place app 
##### purpose 
The purpose of my app is to help young people find answers or even just building blocks to life's big questions. Today we are inundated with options that we can be paralyzed by it, what people need is a clear list of what some of those answers are, according largest portion of the public.

##### Features
-   sorting of closed questions (largest, most responses ect)
-	Sorting active questions (largest, least responses, least time left, newest)
-	Maybe be able to set and sort by tag? (technology, food ect)
-   Deposit and withdrawal features
-   Account balance feature 
-   Count down to closing of question 
-   

##### Target audience NEED HELP ON THIS
The target audiences are people between 20-35 who have skills but short on ideas of what they can do with their free time. They will be people who have some extra cash to be able to spend on a website with no guaranteed return. 


##### Tech stack 
- HTML
- CSS
- Ruby on rails 
- Heroku
- Stripe 
- Bootstrap 


##### USER STORYS
As a Idealab user, I want to be given a reward if I come up with a really good answer for the original poster so that I am incentivized to continue to come up with good answers for other questions. 

As an Idealab user, I want to be able to see what is the question that has the largest prize so that I can have a chance at winning a lot of money for the time that I will spend thinking out a good answer.

As a developer, I would like to to be able to search the active questions for a questions that are related to programing so that I can maximise my chances of giving a winning answer. 

As an Idealab user, I want to be able to view how much money I currently have in my account so that I can see what questions I have enough money to respond to. 

As an Idealab user, I want to be able to see how long a question has until the winner is decided so that I can decide whether it is worth spending my money on making a response to a question. This is because a question that is going to end soon will not give my response enough time to gain likes and become the most liked comment. 

As an Idealab administrator I want to be able to delete inappropriate questions or comments so I have the ability to keep the site free from spam, scammers or trolls.

As a new Idealab user I want to be able to view what the rules for the site are how it works so that I can avoid having questions deleted and so that I know how the service works.

As an Idealab user I would like to be able to deposit money into my account so that I can make questions or comments. 

DATA STRUCTURE
Question has many comments, users. Has one owner 
-	Prize 
-	Closing time 
-	Owner 
-	Title 
-	Description 
-	Response cost 
-	ID
User 
-	Username 
-	Password 
-	Account balance 
-	Total winnings 
Comment has one question, owner 
-	Question 
-	Owner 
-	Body 
-	Number of Likes
Like has one user, comment
-	Owner 
-	comment

#### Describe the way tasks are allocated and tracked in your project
In my project I am using a trello board to track the tasks that need to be completed for this assignment 

I have my trello board separated into catagories that relate to how important/urgent a task is. From the outset of my project I will only be working on the tasks listed in the MVP column as these are the tasks that the most crucial for the most basic functioning of my application. 

Then the column important is for parts of the project that are needed for my project to meet my vision on how I would like my application to function. However, if i did not have these features the application would still function at it's most basic level. 

Then "Nice to have" are things like styling, sorting of questions and another page that shows the list of all of the highest earning users. These tasks either have little or no relevence to the clients wishes however I believe will bring value to the project. 

When I start work for the day I move in all the things I need to have done at the end of the day in to the "in progress" column. Then I will work on these starting with the task I believe I have the greatest chance of completing with little to no external research or discussion with my educator required. 

Once a task is completed a move the trello card from the "in progress" column to the completed column. I then git add and git commit with a message explaining what I have completed in this commit so that later if I wish to revert it is clear where I was up to in that save. 