# Project Overview and Purpose
Django Poll App is a simple web application built using the Django framework. It demonstrates the basic features and structure of a Django application. It is suitable for beginners looking to understand how to build and deploy web applications using Django. This application allows users to create polls, vote on them, and view the results. This application serves as a great example for learning Django's core functionalities, such as URL routing, database models, forms, and templates.
# Features
- Poll Creation: Admin users can create polls with multiple choices.
- Voting System: Users can vote on available polls.
- Results Display: Users can view the results of polls they have voted on.
- Admin Interface: Utilizes Django's built-in admin interface for managing polls.
# Module descriptions

## 1. polls/models.py
Defines the database models for the polls application.
- **Poll**: Represents a poll with fields for the owner (a User), text, publication date, active status, and creation date. Methods include: <br>

Method  | Usage
------- | -----
user_can_vote  | Checks if a user has already voted
get_vote_count  | Returns the total number of votes
get_result_dict  | Provides the poll results as a dictionary

- **Choice**: Represents choices within a poll. Fields include a reference to the poll, choice text, creation date and timestamps. It has a method:<br>
  **poll**: This is a foreign key field linking the choice to a specific question. The on_delete=models.CASCADE argument ensures that if a question is deleted, all related choices are also deleted.<br>
  **choice_text**: This is a character field with a maximum length of 200 characters.
  <br>
- **Vote**: Represents a user's vote on a choice within a poll. Fields include references to the user, poll, choice, and timestamps.

## 2. polls/views.py
Handles the HTTP requests and returns the appropriate responses. It includes views for displaying a list of polls, poll details, and voting.<br>
Function  | Usage
--------- | -----
index()  | Displays a list of recent polls
detail()  | Displays the details of a specific poll
results()  | Displays the results of a specific poll
vote()  | Handles the voting process for a poll

## 3. polls/urls.py
Maps URL patterns to views in the polls application. It defines the URL routes for the application.<br>
|   |   |
|---|---|
|path('', views.index, name='index')| The home page displaying the list of polls |
|path('<int:question_id>/', views.detail, name='detail') | Displays poll details |
|path('<int:question_id>/results/', views.results, name='results')| Displays poll results |
| path('<int:question_id>/vote/', views.vote, name='vote' | Handles the voting process |
