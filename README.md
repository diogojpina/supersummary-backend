# Super Summary Challenge - Diogo Pina

This is a repository for the backend challenge for Super Summary developed by Diogo Pina.

Branch: ruby_version
- Update .ruby-version
Update .ruby-version from 3.1.2 to 3.2.0 to fill the Gemfile requirement

Branch: movies_controller
Remove movies_controller class variables
- Remove @ from movies, recommendations, rented because they don't  need to be a class variable since they are not being use in other places than the method context

Branch: movies_controller_validate_inputs
- Validate input data to movies controller
Validate input data for each movies controller method. If validation failed throw http 400 - bad request and a json error message.

Branch: movies_rent_route
- Change movie rent Rest action
Change movie rent rest action from get to post because this endpoint changes data, so post is more approprieted.
The new request is:
POST /movies/<movie_id>/rent
{ user_id: <user_id> }

Branch: remocommendation_engine
- Improve Recommendation Engine
Get genres using movie ID instead of title, because two movies has same title, it'll fetch both. Besides that, it's faster to select by primary key.
Method get_movie_names required a parameter but that parameter it was not used because it reads the favorite_movies from a class variable (filled on the method initialization).
Then, for the get_movie_ids, I removed the parameter.

Branch: movie_rent_return
- Improve rent and add return action
Added validation to not rent an unavailable movie.
Added return method to controller and configure it to router.
Added validation to return only movies rented.

