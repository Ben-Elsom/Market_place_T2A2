I would like to make an app where users can post questions and other users can give responses to that question. It costs $2 to post a question and 10c to post a comment. 

The $2 (minimum) for creating the question and the 10c for adding a comment will be added to a pool of money for that question.
At the end of a set period of time the question will close and the most liked comment will receive the pool of money that has been collected for the question. 

When starting a question I would like for the user to choose how high the entry for the response should be (from 10c to say $5 depending on how complex the of an answer they are expecting). They should also be able to set how much of a prize/price they would like to set on this question (higher would obviously attract more responses) 


#### Identification of the problem you are trying to solve by building this particular marketplace app.

Coming up with good ideas is hard. All industries and classes of people (Professional, casual, student) need to come up with unique, innovative or plain just good ideas for whatever it is they are doing.
I want to help these people with the issue i have seen people facing, coming up with good ideas is hard. 



My app Idealab is a new idea generating framework that allows users to harness the power of numbers while 

There are casual services that can help people generate ideas but they are either not specific enough (name generators) or have lots of low quality answers (Ask reddit, Instagram polls).

My app “Idea Lab” is a brainstorming website with prizes for the best ideas and barriers to entry for responses so that only ideas that creators believe are decent will be posted. This will allow for a better idea generating service then anything that is currently available on the internet. 


#### Why is it a problem
Individuals can be delayed from action purely because they just do not have something that they believe is a good idea to work on. This reduces the amout of time that that individual can spend on actually working on their project. I want to assist people with the first part of any good project which is coming up with a good idea. 

#### Link to website 

https://idealab2.herokuapp.com/

#### link to github 
https://github.com/Ben-Elsom/Market_place_T2A2

#### description of market place app 
##### purpose 
The purpose of my app is to help it's users come up with the best answer or just ideas for whatever it may be that they are pondering in their life/business.

##### Features
- Autherization - log in and sign up allows users to have their own personal account, balance and username.

- Ability to make question - Question includes information such as headlining question, description of that question, set the prize, set the response cost, set the time it will close and upload an image for further explanation. Making this question removes the prize amount from the users account 

- Ability to make responses - To make a response requires that the user have enough money in their account to pay the questions response cost. If they do have enough money and want to make a comment, they type it into the comment box and hit submit. The response cost of the question is taken from the current users balance and the users comment is added to the relevant questions comment index 


- Ability to like and unlike comments - If the user is not the question owner then they will have the ability to like response on a questions show page. This can only be done once and then the button for that question is changed to an unlike button which if the user clicks it will delete their like on that response.



- Ability to make questions with a headlining question, description of that question, set the prize, set the response cost, set the time it will close and upload an image for further explaination
- Ability to make response to questions 
- Ability to unlike comments 
- 
- 

##### Target audience NEED HELP ON THIS
The target audience for my app on the questions side are people aged between 20-35 who have a moderate amount of skill in an field who will be able to make something from the ideas they are given and such will be willing to spend money to be able to receive these ideas. 
On the response side it is any one who has some amount of expendable income that they are willing to be gamble on a response to a question. These users will most likely be older and well educated as they will have more expendable income and a belief that the ideas they can come up with are well thought out. 


##### Tech stack 
- HTML - This was used on my application to structure, add and occasionally style content to my webpage. It was used for things like making tables, making headings, adding text and bolding text 
- CSS - This was used to style elements on my website where bootstrap did not do exactly what I wanted. UPDATE THIS
- Ruby on rails - I used Ruby on rails as the framework for my application. This was used to 
- Heroku - I used Heroku to deploy my application. I set up automatic deployment on my website so that each time I push my code to my github repo "Main" heroku will see the change and will automatically apply the chanegs to my deployed website 
- Bootstrap - I used bootstrap for the majority of my styling as this is the most efficent way to make my website visually pleasing. 


##### USER STORYS
My user stories are stored inside of each of my trello cards. 
https://trello.com/b/baNUCtjg/market-place-assignment

#### Sitemap

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

#### Explain the different high-level components (abstractions) in your app
User - For my application to work each user of the website will need to make an account. In making an account they add their email address, create a username and create a password. Once their account is made they will be given a starting balance of $200. The only way for a user to make more money is to be the most liked comment at the end of the active session for a question. If a user wins an question they will receive the entire prize pool into their account. 


Question - A question is made by a user. A question most contain, a title, a base prize that will be taken from the question makers account balance, a response cost that will be taken from the users account balance when they make a comment and added to the prize and a closing date and time where the question winner will be decided and no more comments will be able to be added. The question maker also has the option of adding a more in depth question description to give the responders more background information as well as the option to add a explaination photo which can also be used to provide further context.
At the end of a question when the winner is being decided, Idealab will check the question to see if there is a clear winner, if there is not then the price will not be given. The next time the creator of that question logs on they will be prompted to give the tie breaking like between all of the comments that have the same number of likes. Then the program will attempt to create a winner and now the tie is broken and so the comment that the question owner liked will have the most and will be awarded the prize pool. 


Comment - A comment (aka response) is what another user can make to a question to add themselves into the running to win the prize. The cost of the response will vary depending on the question as this amount is decided by the question maker at the creation of the question (higher response cost will mean less responses but likely higher quality and vise versa). The comments are displayed on the show page for a question in order of most to least likes. Comments are also created on the show page for a question. Users cannot edit or delete their comments once they are made however an admin account has the ability to delete any comment with no refund. 

Like - A like is a free token that users can give to other users comments to signify that they like the comment. A user can only give one like to to a comments but can give as many comments a like as they want. Users can also like their own comments. Users also have the ability to remove their like from a comment at any time while the question is still active. Likes are used to decide the best response at the end of the questions active time. The creator of the questiom cannot like any comments on their own post as they are the deciding vote in the event of a tie. 

#### Detail any third party services that your app will use
I did not use many 3rd party services in my application as it was not necessary and/or a smart use of my time. The only 3rd part service I used was Heroku

Heroku - My application uses the free version of Heroku for deployment. Heroku allows for speedy deployment of an application as it allows the developer to use ready made environments to deploy your code. This worked for my me as we only had a short time to create the application and using AWS can be confusing and complicated for a newer programmer like myself. Heroku hosts the web applications code and database. The code on heroku can be updated by updating the code in Ben Elsom's, Marketplace Assignment repo, Main branch. The database can only be updated by a user on the website making a post or delete request on the deployed website or the application owner by using the command "Heroku run rails c" in their terminal.

Cloundinary - Cloudinary is used to old any of the images displayed on my web application. When creating a question users can upload an image that provides further context on their question. When this photo is pulled down from cloudinary it will only pull down the required number of pixels that the web page is asking for. 

Bootstrap - I used bootstrap to style my webpage. I have links in my application html that connect to the bootstrap service/stylesheets that allows me (the developer) to add classes to elements in my view so that 

R17 
what are the active record associations between the models 
Then what do the associations mean 
and why do each one of them have that associations and what does that mean in the context on that app
HAs many through 

R18 
A relation is a table and realtionships between them. one to one one to many 
why does a foregin key go onto the table that it does. 
Why do we use joining tables 
Why do we not just have many items on one table. NORMALIZATION

CHeck that I don't need to be using has many through 


