# sinatra_test

  To run locally
 
  ```
  bundle install
  bundle exec rackup -p 9292 config.ru &
 ```

 Ensure you have config/secret.yml file, with the API key set, for example
 ```
 api_key: my_api_key
 ```

 or the fyber_api environment variable set

 Design process

 I used a REST client to try the API out first in my browser and see what responses it generated,
 as well as using the fyber documentation. This informed the creation of the Request class.

 I initially created a class to generate the requests for the Fyber API, including generating the hash key,
 as this is very self-contained and specific to this application. If other request types were required,
 then the common functionality of generating the hash key and setting params could be moved out in to a super class,
 which request-type subclasses could inherit from.

 I decided to use sinatra as my framework as it is very lightweight and quick to get something running in, 
 although larger apps become more difficult to maintain without helper functions or a more rigid structure (such as those provided in Rails).

 I used heroku as my deployment platform as it is the fastest platform I am aware of to get something deployed quickly, due to the minimal configuration required.

