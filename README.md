# GENERATED README NOTE

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Info

* Author Name: Mitchell Van Braeckel
* Email: mvanbrae@uoguelph.ca
* Student ID Number: 1002297
* Course: CIS*3260 Software Design IV
* Assignment: Individual A2
* Professor: Mark Wineberg
* Language: Ruby on Rails
* Brief: CupThrow Game - Play a Game with Coins and Dice against a computer to win gems, buy more items, and continue. Try to get a high score, it remembers your account.
* Due Date: (Extended, Twice) Wednesday, October 27, 2021

## General

NOTE: I will say the URL of each page, but it's highly recommended to only navigate using the links and buttons as that's how it was designed.

Below please find general comments and statements, as well as an overview of everything I implemented with respect to A2 and how to get there

* General source: https://www.railstutorial.org/book
* General source: https://guides.rubyonrails.org/, especially https://guides.rubyonrails.org/getting_started.html
* Referenced source for sign-in and user pages and functionality: https://carsonrcole.com/blog/posts/rolling-your-own-authentication-in-rails-5
  * additional referenced source: https://medium.com/@ashleymcolletti/add-authentication-to-your-rails-app-with-bcrypt-a53917252159
* "Hello World" is working, go to `/articles` or `/articles#index` to see "Hello, Rails!"
* I integrated and implemented my own A1 code (you can find them all in the `app/models/` folder as ruby `.rb` files)
  * A few extra things are in the `/a1info` folder, but that's like tests, PDFs, texts files, etc.
* I've included some extra documents in my submission (like the A2 info) because it was also in my GitHub repo already
* Sign-in page
  * For sign in functionality, go to `/login`
    * asks for username, email, and password
    * validates provided info, such that an account exists for this user
      * covers things like successful sign in, wrong password, and invalid user/pass such that user does not exist and they need to create an account via sign up
      * shows these warnings/errors on the same page and lets the user try again
    * redirects to the user's home page after signing in
  * For sign up functionality, go to `/signup`
    * asks for username, email, and password
    * validates the provided info
      * covers things like unique email address, and others similar to sign in
      * shows these warnings/errors on the same page and lets the user try again
    * redirects to login page after so the user can sign in after making their account
* User's Home page
  * go to base URL, or `/home`
    * shows username, email, points, gems, and bag contents (ie. list of items)
    * can logout and it returns to sign in page
    * can delete account removing user account and all items, also logs them out
    * can play a game, which goes to the initial game's landing page with rules, etc. and hidden goal description if they select to play game
    * can purchase items, which goes to a new form to choose characteristics of the item to be purchased
* Purchase Items page
  * For the form to buy a new item, go to `/purchase_items` (or `/purchase_items/new`)
    * also lists user email, points, and gems
    * fill in the form fields to select an error
      * has error checking and validation
        * some of this will be seen as an alert/notice at the top notifying that inapplicable field data was ignored when buying the item
        * otherwise, shows warnings/errors on the same page and lets the user try again
    * redirects back to this same page to allow the user to easily continue buying more items
      * this happens after the item specified has been created
    * can exit back to the user's home page
* Play Game landing page
  * For the game's landing page, go to `/games`
    * also lists user email, points, and gems
    * here, rules, etc. are displayed, including the hidden goal description if the user selects to actually start/play game
    * can start/play game
    * can exit back to the user's home page
* Play Game game page
  * For the game's actual page where the game is played, go to `/playgame`
    * also lists user email, points, and gems
    * game results are calculated and displayed
      * designed so that the game will work properly even if someone directly navigates to this page instead of going to the game's landing page first
    * shows the game results
      * shows the goal, including goal type and coin and/or die goal description(s), depending on what was randomly generated earlier for the goal type
      * shows the throw results applicable to the goal for both the user/player and computer/CPU
        * shows sum or tally of both results, depending on what was randomly generated earlier for the goal type
      * shows a message indicating if the user/player won or lost
        * also shows how many points and gems were earned (if any), including what the user now has after that addition
    * can exit to the user's home page
    * can go back to the game's initial landing page
    * can play a game again without navigating back to the game's initial landing page
      * Simply refreshing this page will start and execute/complete a new game (ie. with a new goal)
* as a few extras, there's secret views/pages that can be accessed (while already signed in) as an admin/moderator view
  * can find it by going to `/users`
    * this shows all users with accounts, including options to show, edit, or destroy/delete each one
      * note that destroy/delete a user this way will sign out current user as a safety precaution
        * also note that destroying/deleting a user this way will also destroy/delete/remove all their items
    * back will redirect to the signed-in user's home page
    * new user is a shortcut to signup a new user (without logging out first or anything or affect current sign in)
    * for editing a user, it's a similar form to signing up
      * note that for both, I've added a hidden form field that can be found and changed by inspecting in browser
        * these make it easy to update a user's points and gems for testing
    * for showing a user, note that this is similar to but different that the signed-in user's home page
      * also shows username, user email, points, and gems (but slightly, formatted different)
      * can go back to home (ie. the signed-in user's home page)
      * can edit the user being viewed
      * can destroy/delete the user being viewed
        * note that destroy/delete a user this way will sign out current user as a safety precaution
          * also note that destroying/deleting a user this way will also destroy/delete/remove all their items
      * can click on bag contents to see all the items other than in the bulleted list form
        * shows all items for the user being viewed, including the associated user email, item type, denomination (if coin), and/or sides + colour (if die)
          * for each item being shown, you can show (view the item individually), edit, and/or destroy/delete
            * when viewing an item individually via show, you can go back to the items expanded moderator table list view, edit the item, and/or destroy/delete the item
          * can go back to that user's admin/moderator view page
          * can quickly create a new item without paying gems, so helpful for testing this way too
        * note that for editing an item, it's similar to purchase items, but different and more free form (just text fields) -> in general, a mod should know what they're doing and doesn't need to be handheld
          * it still has the same/similar validation, but looks different and doesn't display warnings/errors in the exact same way
            * for example, it will ignore inapplicable form fields for an item, but not give a warning

### Grading Scheme & Rubric

* "Hello World" is working
  * [3 pts] Shows connectivity from client to server and the ability to modify the routes file and view
* Sign-in Page
  * [3 pts] Demonstrates ability to use scaffolding to obtain and store info from a user into the database through the manipulation of Control and Model and View code
* Users Page
  * [1 pt] Requires similar skills as the Sign-in page, but now with control over the extra logic needed to switch between web pages as well as allowing for more than one URL request by the client on the server
* Play Game
  * [1 pt] Simple "game"
    * i.e., some manipulation of a throwing dice and coins from a cup
    * You can make up the "rules", just inform the TA what they are in your read.me
    * Demonstrates the ability to manipulate instances of some of the classes obtained from the Rails model in an OO fashion
  * [3 pts bonus] Full game
    * Demonstrates the ability to create an "application" with proper OO interaction, using instances obtained from the Rails model and accessed from the controller and use it to process the game logic and create game pages from the view to display
* Items
  * [0.5 pts bonus]
    * No new skills demonstrated
    * Just hereto complete the game and make it more fu

#### Submission Instructions

* Submit your source code in a single zipped (or tarred) directory through CourseLink
* Make sure your Rails server is running your website either at the time of submission, or when informed through CourseLink that the TAs have begun grading, until informed that grading has completed
* The Rails application should be called "CupThrow"

For convenience, I'll write here that my assigned port number is 32025. If for some reason my app stops running, please let me know and I can restart it. I'd first check via `lsof -i :32035` to see if it's still running, then I'd stop it via `kill -9 $(cat tmp/pids/server.pid)` if it was still running, and finally I'd restart it via `rails server -d -p 32035 -b 0.0.0.0`.

Since nothing was explicitly specified, I've submitted a zipped folder that contains my `CupThrow` application as outlined and created via the documents and instructions we were provided. However, it uses the generated `.gitignore`, where I've also told it to ignore `/vendor`.

Also, note that I completed the items purchasing bonus 0.5 page, and also did a lot of work for the 3pts bonus "full game". My rules match up perfectly, except I didn't have the option for the user to select which items they load for a throw. Instead, it creates the optimal throw based on their items and the randomly generated goal, such that it also maximizes possible earned points via maximizing the multiplication factor when determining points won.
