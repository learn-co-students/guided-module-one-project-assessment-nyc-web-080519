Hogwarts School of Witchraft and Wizardry CLI
========================

![hogwarts](https://cdn.gbposters.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/f/p/fp4759-harry-potter-hogwarts-day_1.jpg)

## Project Overview

This is a final project for Module 1 of Flation School.

We were asked to build a **Command Line CRUD App** that uses a database to persist information. The goal of which is to demonstrate all of the skills that we learned in module one:

- Ruby
- Object Orientation
- Relationships (via ActiveRecord)
- Problem Solving (via creating a Command Line Interface (CLI))

**Minimum requirements** for this project were to build a Command Line App that:

1. Contains at least three models with corresponding tables, including a join table
2. Accesses a Sqlite3 database using ActiveRecord
3. Has a CLI that allows users to interact with your database as defined by your _user stories_ (minimum of four; one for each CRUD action)
4. Uses good OO design patterns. You should have separate models for your runner and CLI interface

---

## Setup

1. Fork and clone this project repository
2. In terminal, run `bundle install`
3. In terminal, run `rake db:migrate`
4. In teminal, run `rake db:seed`
5. Start the app by running `ruby bin/run.rb`
6. Follow instructions/prompts from our CLI app
7. Enjoy!

![McGonagall clapping](https://media.giphy.com/media/PXvCWUnmqVdks/giphy.gif)


---

## Models

Student, Professor, Course, House
* A student has many professors, through courses
* A Professor has many students, through courses
* A student has many courses
* A course belongs to a student
* A professor has many courses
* A course belongs to a professor
* Houses have mny students
* A student belongs to a house

---

## Schema

Student
* `name`: string
* `dumbledores_army`: boolean, indicating if they are a member
* `order_of_the_phoenix`: boolean, indicating if they are a member
* `house_id`: integer, foreign key referencing `house id` primary key

Professor
* `name`: string
* `order_of_the_phoenix`: boolean, indicating if they are a member
* `dumbledores_army`: boolean, indicating if they are a member
* `specialty`: string, subject that they teach/specialize in

Course
* `name`: string
* `subject`: string
* `student_id`: integer, foreign key referencing `student id` primary key
* `professor_id`: integer, foreign key referencing `professor id` primary key

House
* `name`: string
* `colors`: string
* `values`: string
* `mascot`: string
* `house_ghost`: string
* `founder`: string

---

## User Stories

Create
* As an incoming student, I want to be able to add a new student
* As a student, I want to be able to add a course

Read
* As a student, I want to be able to see all of my courses
* As a student, I want to be able to see all of my professors
* As a student, I want to be able to see all of my classmates
* As a student, I want to be able to see all students
* As a student, I want to be able to see if a student is my classmate
* As a student, I want to be able to see all students in Dumbledore's Army
* As a student, I want to be able to see all students in Order of the Phoenix
* As a student, I want to be able to see all of my housemates
* As a student, I want to be able to see all courses
* As a student, I want to be able to see the most popular course
* As a student, I want to be able to see the least popular course
* As a student, I want to be able to see courses by size
* As a student, I want to be able to see courses by subject
* As a student, I want to be able to see all professors
* As a student, I want to be able to see the most popular professor
* As a student, I want to be able to see professors by subject
* As a student, I want to be able to see courses by professor
* As a student, I want to be able to see students by professor
* As a student, I want to be able to see all houses
* As a student, I want to be able to see students by house
* As a student, I want to be able to see the house with the most students
* As a student, I want to be able to see the house with the least students

Update
* As a student, I want to be able to join Dumbledore's Army
* As a student, I want to be able to join Order of the Phoenix
* As a student, I want to be able to leave Dumbledore's Army
* As a student, I want to be able to leave Order of the Phoenix

Delete
* As a student, I want to be able to drop a class
* As a student, I want to be able to drop out of Hogwarts

---

## API

We used the [Potter API](https://www.potterapi.com/) to seed our database and create students, professors, and houses. We created a list of courses and subjects and students randomly get added to 3 courses when we seed the database.

---

## Things to check out

* Make sure the sound on your computer is turned on

![wizard harry](https://media.giphy.com/media/eax0rh3OERAYg/giphy.gif)

* Create a new student and get sorted into a house

![sorting hat](https://media.giphy.com/media/Tl2AK8HOHj7SU/giphy.gif)

* Try entering your name as: `I solemnly swear I am up to no good`. (Hint: type `Mischief Managed` to go back)

![I solemny swear I am up to no good](http://giphygifs.s3.amazonaws.com/media/NsXfE1pDj0ZNu/giphy.gif)