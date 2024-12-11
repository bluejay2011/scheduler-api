
# Scheduler API

An API only ruby on rails application mainly designed to filter the events a person can book. The result should only contain events that don't clash with events the person already booked into.

# Setup your local machine
- Clone a copy in your repo.
- Setup [docked](https://github.com/rails/docked). Install Docker (and WSL on Windows). Then copy'n'paste into your terminal:
```
docker volume create ruby-bundle-cache
alias docked='docker run --rm -it -v ${PWD}:/rails -u $(id -u):$(id -g) -v ruby-bundle-cache:/bundle -p 3000:3000 ghcr.io/rails/cli'
```

- Then run the rails server using this command
```
docked rails server
```

- Once server is running, let's add the initial test cases
```
  docker exec -it <container name> bash
  rails db:seed
```

- This will create 4 users, and the events related to each user based on the examples given.
    - A user can have many events.
    - Events can be compared from one user to another.


# Assumptions:
- Same timezone.
- No double booking / overlapping events for each user.
- No different dates in booking, always use the same day for start time and end time.
- Start time and end time will always be by 24-hours format in 30 minutes block. (eg: `2018-12-29 13:30:00`)
- I did not prioritize input validation in payload, and assumes the format and data type entered will be correct. I've created postman examples to guide user.


# Flow:
- Every events created are mapped to a single user.
- By using the endpoint `GET {{base_url}}/events?user_id=<student ID>&available_with_user_id=<university ID> wherein <student ID> is my events and <university ID> is the events from where I'm comparing with.
  - I loop through the events with checks and put them inside a hash map. This helps validate if there are conflicts on the same day and block of time for the week.
  - I also register the event in an array as a reference on event details.
  - Once the hash map of events are created for each user, I compare it based on the keys. The events that didn't encounter any conflict will be returned.
