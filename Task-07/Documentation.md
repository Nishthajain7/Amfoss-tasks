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

# Getting Started
<p>These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.</p>

<h2>Prerequisites</h2>
<code>python== 3.5 or up and django==2.0 or up</code>

<h2>Installing</h2>
<pre>open terminal and type</pre>
<code>git clone https://github.com/devmahmud/Django-poll-app.git</code><br><br>

<h4>or simply download using the url below</h4>
<code>https://github.com/devmahmud/Django-poll-app.git</code><br>

<h2>To migrate the database open terminal in project directory and type</h2>
<code>python manage.py makemigrations</code><br>
<code>python manage.py migrate</code>

<h2>To use admin panel you need to create superuser using this command </h2>
<code>python manage.py createsuperuser</code>

<h2>To Create some dummy text data for your app follow the step below:</h2>
<code>pip install faker</code>
<code>python manage.py shell</code>
<code>import seeder</code>
<code>seeder.seed_all(30)</code>
<p>Here 30 is a number of entry. You can use it as your own</p>

<h2> Configuring OAuth login </h2>
<details>
    <summary>Obtaining OAuth Client ID for Google</summary>


1. **Go to the Google Cloud Console:**
   - Navigate to [Google Cloud Console](https://console.cloud.google.com/).
   - Sign in with your Google account.

2. **Create a new project:**
   - Click on the project dropdown menu at the top of the page.
   - Click on "New Project" and follow the prompts to create a new project.

3. **Enable the Google Identity service:**
   - In the Google Cloud Console, navigate to "APIs & Services" > "Dashboard."
   - Click on "Enable APIs and Services."
   - Search for "Google Identity" or "Google+ API" and enable it for your project.

4. **Create OAuth consent screen:**
   - In the Google Cloud Console, navigate to "APIs & Services" > "OAuth consent screen."
   - Fill in the required fields (like application name, user support email, etc.).
   - Add scopes (permissions) your application requires.
   - Save the consent screen information.

5. **Create OAuth credentials:**
   - In the Google Cloud Console, navigate to "APIs & Services" > "Credentials."
   - Click on "Create Credentials" > "OAuth client ID."
   - Select "Web application" as the application type.
   - Enter a name for your OAuth client.
   - Add authorized redirect URIs : `http://127.0.0.1:8000/complete/google-oauth2/`
   - Click "Create."

  6. **Copy the client ID and client secret:**
   - Once the OAuth client is created, you'll see your client ID and client secret.
   - Copy these values and update the following variables in settings.py

        ```
        SOCIAL_AUTH_GOOGLE_OAUTH2_KEY = 'your-client-id'
        SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET = 'your-client-secret'
        ```
For detailed instructions, refer to Google's documentation on [OAuth 2.0](https://developers.google.com/identity/protocols/oauth2).
</details>

<details>
   <summary>Obtaining OAuth Client ID for Facebook</summary>
   
1. **Create a Facebook App:**
   - Go to the [Facebook Developers](https://developers.facebook.com/) website and log in.
   - Click on "My Apps" and then "Create App".
   - Enter the required information for your app (display name, contact email, etc.) and create the app.

2. **Configure Basic Settings:**
   - In your app dashboard, go to Settings > Basic.
   - Add a platform (select Website) and enter your site URL(http://127.0.0.1:8000/complete/facebook/).
   - Save your changes.

3. **Get App ID and App Secret:**
    
    - Update the following settings to your settings file, replacing `'your-facebook-client-id'` and `'your-facebook-client-secret'` with your actual LinkedIn app credentials:
     ```python
        SOCIAL_AUTH_FACEBOOK_OAUTH2_KEY = 'your-client-id'
        SOCIAL_AUTH_FACEBOOK_OAUTH2_SECRET = 'your-client-secret'
     ```

</details>
<details>
  <summary>Obtaining OAuth Client ID for LinkedIn</summary>

  ### Step 1: Create a LinkedIn App
  1. Go to the [LinkedIn Developer Portal](https://www.linkedin.com/developers/) and sign in.
  2. Click on "Create App" and fill in the required details, such as the app name, description, and logo.
  3. In the "Authorized Redirect URLs" section, add the callback URL for your Django app. This URL will be like `http://127.0.0.1:8000/complete/linkedin/`.
  4. Save the changes and note down the Client ID and Client Secret provided by LinkedIn.

  ### Step 2: Configure Django Settings
  
    1. Update the following settings to your settings file, replacing `'your-linkedin-client-id'` and `'your-linkedin-client-secret'` with your actual LinkedIn app credentials:
     ```python
     SOCIAL_AUTH_LINKEDIN_OAUTH2_KEY = 'your-client-id'
     SOCIAL_AUTH_LINKEDIN_OAUTH2_SECRET = 'your-client-secret'
     ```
</details>

<h2> To run the program in local server use the following command </h2>
<code>python manage.py runserver</code>

<p>Then go to http://127.0.0.1:8000 in your browser</p>


