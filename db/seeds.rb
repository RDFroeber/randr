# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# Delete ALL prior entries in database
Author.destroy_all
Favorite.destroy_all
Book.destroy_all

author = Author.create(name: "J.K. Rowling", alive: true)
author.book = Book.create(title: "Harry Potter and the Goblet of Fire", author_id: 1, isbn: , published_date:, img_url_sm: "", img_url_lg: "", buy_link: "")

user = User.first
myfav = Favorite.create(user_id: user, author_id: 1, notify: true)