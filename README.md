# README

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

## my stuff

- Source for sign-in and user pages and functionality: https://carsonrcole.com/blog/posts/rolling-your-own-authentication-in-rails-5
- "Hello World" is working, go to `/articles` or `/articles#index` to see "Hello, Rails!"
- Sign-in page
  - For sign in functionality, go to `/login`
    - asks for email and password
    - covers successful sign in, wrong password, and invalid user/pass such that user does not exist and they need to create an account via sign up
  - For sign up functionality, go to `/signup`
    - asks for username, email, and password
- user's page
  - go to base URL, `/home`, or `/home#index`
    - shows username, email, poitns, gems, and bag contents
