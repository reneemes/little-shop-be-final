# Little Shop | Final Project | Backend Starter Repo

This repository is the completed API for use with the Mod 2 Group Project. The FE repo for Little Shop lives [here](https://github.com/turingschool-examples/little-shop-fe-vite).

This repo can be used as the starter repo for the Mod 2 final project.

## Setup

```ruby
bundle install
rails db:{drop,create,migrate,seed}
rails db:schema:dump
```

This repo uses a pgdump file to seed the database. Your `db:seed` command will produce lots of output, and that's normal. If all your tests fail after running `db:seed`, you probably forgot to run `rails db:schema:dump`. 

Run your server with `rails s` and you should be able to access endpoints via localhost:3000.



# Little Shop -- Coupons 

### Abstract:
[//]: <> (Briefly describe what you built and its features. What problem is the app solving? How does this application solve that problem?)
The application is designed to simulate an admin portal for a online store. The user is able to see a list of all the merchants, update their info, view their listed items, delete the listings, and view their store coupons.

### Context:
[//]: <> (Give some context for the project here. How long did you have to work on it? How far into the Turing program are you?)
This project is built off of an already existing repo, similar to one from a previous group project. The task was to add coupon functionality to the online store.

### Contributors:
[//]: <> (Who worked on this application? Link to your GitHub. Consider also providing LinkedIn link)
[Renee's LinkedIn](https://www.linkedin.com/in/reneemessersmith/)

### Learning Goals:
[//]: <> (What were the learning goals of this project? What tech did you work with?)
* Write migrations to create tables and relationships between tables
* Implement CRUD functionality for a resource
* Use MVC to organize code effectively, limiting the amount of logic included in serializers and controllers
* Use built-in ActiveRecord methods to join tables of data, make calculations, and group data based on one or more attributes
* Write model tests that fully cover the data logic of the application
* Write request tests that fully cover the functionality of the application
* Display data for users in a frontend application by targeting DOM elements

### Wins + Challenges:
[//]: <> (What are 2-3 wins you have from this project? What were some challenges you faced - and how did you get over them?)
Wins:
1. Working with a front-end that pulled data from an API
2. Styling the front-end coupons view
3. Getting the application functionality up and running<br>

Challenges:
1. Createing migrations
2. Working out the different error codes for each different create sad path
3. Diving into a front-end after not working in JavaScript in a long while
4. Figuring out what goes where and how much logic is too much logic in the controller