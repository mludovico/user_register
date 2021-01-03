# user_register_app

A Flutter user registration app using firebase to authenticate.

### Note

This app uses firebase, facebook login and google auth api. So it requires some secrets (keys, hashes and special configs) which will not be published. Refer to the [Firebase documentation](https://firebase.google.com/docs/auth), [Facebook developer](https://developers.facebook.com/docs/facebook-login/) and [Google developers](https://developers.google.com/) for further information.

## Scope

This app is a simple implementation of firebase auth funciotnalities using commom Flutter widgets with some custom configuration. Within this app is possible to login using a pre-existing user and password, create an account with user and password, create an app's account with Facebook Account and create an app's account using Google account.
Some field validation is used in fields such as email, password, username as well as formatters in phone, zip code and date to give it better visualization.

## Screens
  
### Login
<img src="https://github.com/mludovico/user_register/raw/master/media/ura_login.png" height="600"/>
  
### Password Recovery
<img src="https://github.com/mludovico/user_register/raw/master/media/ura_recover.png" height="600"/>
  
### Register
<img src="https://github.com/mludovico/user_register/raw/master/media/ura_register.png" height="600"/>
  
### Register multiple fields for addresses and phones
<img src="https://github.com/mludovico/user_register/raw/master/media/ura_register_multiple_fields.png" height="600"/>
  
### Login with facebook
<img src="https://github.com/mludovico/user_register/raw/master/media/ura_login_facebook.png" height="600"/>
  
### Home screen with Facebook user
<img src="https://github.com/mludovico/user_register/raw/master/media/ura_home_facebook.png" height="600"/>
  
### Home screen with Google user
<img src="https://github.com/mludovico/user_register/raw/master/media/ura_home_google.png" height="600"/>
  
### Home screen with user and password
<img src="https://github.com/mludovico/user_register/raw/master/media/ura_home_email.png" height="600"/>
  
## State management
  
The state management is made with bloc provider. Each screen has a respective bloc to manage authentication and signing, login, logout events.

## Integrations

The app uses the [viacep](https://viacep.com.br/) api to retrieve jsonn address information and automatically fill the subsequent fields. Each address added brings a zip code field that can then search for the given code. The fields can still be edited after.

## Firestore

When the users register themselves with email and password, the information provided in the register screen fields is also saved to firestore in a document with an uid that is equal to the user uid. It can be used after to retrieve user information inside the app, altough nothing has been really implemented after the home screen.

### Feel free to [contact me](https://github.com/mludovico) for more information.