# Blog'n Post Project

Blog'n Post (Simplified from "Blog And Post") is a simple blogging web application that allow users to share posts and comments to public.


### Restrictions
A visitor can sign up with regular registration form or by using Facebook or Google
after registration, User will be applicable to share comments on others posts.
While also he/she can start posting. but in Blog'n Post case, each time the user will create a post, he/she is required to validate account using OTP 2FA. otherwise, the post will be saved as drafted until the user verify it. 
A user can control the post status, which means if it's drafted he/she has the ability to validate it and it will be published, and if it's already published the user can hide it. or republish after it was hidden. 


### Deep Look Into Scope
Each user registered, by default will get a :user role. which is controlled by a sort of abilities and roles implemented into our project. 

Each Post have a category, the user has the right to specify which category can fit with post needs, Unless the category is set to be in-active. in this case neither the user or visitor can see it.

User also has the ability to update his/her information, except email. 


### Starting with project
+ Clone this repository
+ run - rails db:setup
+ before seeding the database, go to seeds.rb and update the user details
+ run - rails db:seed
+ Inside seeds.rb it's written to give the created user a role superadmin, in this case the user will have the ability to control everything.


**Stack and Tech notes**

+ Ruby 2.4.2p198, Rails 5.1.6
+ Bootstrap Sass, Haml, JQuery
+ Simple Form, Font Awesome, Devise, CanCanCan, Rolify, Faker, Dotenv, Country Select, Omniauth, Omniauth Facebook, Omniauth Google Oauth2, Impressionist, Authy, Growlyflash .. Used to support this project.

### On Production
Using Dummy in the early stages of front-end development can give you a new perspective on your work every time your document is reloaded in the browser, shortening and improving your test cycle by more quickly exposing weak-points or trouble areas as you go about marking up a new design. It's like watching a time-lapse video of your layout performing with real data.


### License
Dummy is released under a Creative Commons Attribution-Share Alike 3.0 United States license (http://creativecommons.org/licenses/by-sa/3.0/us/). Be a doll and let us know how you're using Dummy, or if you've used it to help build, test or demo anything interesting.

### Credits
Credits and image license information can be found in dummy/CREDITS.md