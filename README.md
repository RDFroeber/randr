RandR
========
* GitHub: https://github.com/RDFroeber/randr
* Heroku: http://randr.herokuapp.com
* Ruby version 2.0.0

---

## Summary:
RandR is a web app designed to help users keep track of their favorite authors, upcoming book releases of said authors, and their favorite books using data from Amazon's Product Advertising API.

---

### APIs Used
+ Amazon's Product Advertising API 
  * used for...
  * Gems: jruby-openssl, vacuum, multi_xml

+ Goodreads API
  * used for...
  * Gems: ...


---

## ERD:
+ Users (Login credentials)
  * has a name
  * has an email
  * has a password digest

+ Authors
  * has a name
  * alive?
  * alert?

+ Books
  * has a title
  * has an author_id reference
  * *belongs to Author*
  * has an isbn
  * has a published date
  * has a small image url
  * has a large image url
  * has a buy link
  * future release?

+ Favorites
  * has a user_id reference
  * *belongs to User*
  * has an author_id reference
  * *belongs to Author*
  * notify?

+ Libraries
  * has a user_id reference
  * *belongs to User*
  * has an book_id reference
  * *belongs to Book*

---

## User Stories:

**As a User**

1. I want to be able to create an account so that my personal information is saved and secure.

2. I want to be able to login to my account so that I can access my personal information.

3. I want to be able to search for an author by the author's name so that I can save said author to my favorites.

4. I want to be able to search for an author by a book they have released so that I can save said author to my favorites.

5. I want to be able to save an author to my favorites so that I can access the informatoin at a later date and recieve updates based on my saved favorites.

6. I want to recieve emails with information about future book release dates from my saved authors.

7. I want to...



+ Functionality:
  * Book Search
  * Saved Books in My Library
