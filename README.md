# ExPoll

To start your Phoenix server:
  * Clone the project  `git clone <url>`
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Endpoints
### Create a new Poll
```bash
$ curl -H "Content-Type: application/json" -X POST -d '{"poll":{"question":"What is your favorite band?"}}' http://localhost:4000/api/polls
=> {"data":{"id":1,"question":"What is your favorite band?"}}
```

### Get all Polls
```bash
$ curl -H "Content-Type: application/json" -X GET http://localhost:4000/api/polls
=> {"data":[{"id":1,"question":"What do you will eat today?"},{"id":2,"question":"What is your favorite band?"}]}%
```

### Get a Poll by id
```bash
$ curl -H "Content-Type: application/json" -X GET http://localhost:4000/api/polls/2
=> {"data":{"id":2,"options":[{"id":1,"value":"Pantera","vote_count":2},{"id":2,"value":"Hatebreed","vote_count":1}],"question":"What is your favorite band?"}}%
```

### Create options for a Poll
```bash
$ curl -H "Content-Type: application/json" -X POST -d '{"option":{"value":"Planet Hemp"}}' http://localhost:4000/api/polls/2/options
{"data":{"id":12,"value":"Planet Hemp"}}
```

### Get option by id about a poll
```bash
curl -H "Content-Type: application/json" -X GET http://localhost:4000/api/polls/4/options/1

{"data":{"id":1,"value":"Pantera"}}
```
