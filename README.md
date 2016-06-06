## Versioned Key Value Store API

### Languages and Tools Used
1. Ruby on Rails for API
2. RSpec Rails for Unit testing
2. Redis for key value storage
3. Heroku for hosting live site

### Installation

1. Make sure you have redis installed on your system. If not, installation instructions [here](http://redis.io/topics/quickstart). 

   While installation, make sure you keep all defaults, i.e, IP address of the host should be local host IP : **127.0.0.1** and the port should be : **6379**
   
2. Run bundle


	```
	$ bundle install

	```  
 3. Start rails server
 
 	```
 	$ rails c
 	```
 	
### Live Application

#####Add Key Value

```
[POST] http://key-value-store-api.herokuapp.com/store
```

REQUEST:

```
{
    "key_value": {
        "liveTest": "Live Test - 1"
    }
}
```

Response:

```
[
  {
    "value": "Live Test - 1",
    "ts": 1465233310
  }
]
```

##### Get Key Value

```
[GET] http://key-value-store-api.herokuapp.com/store/<key>?timestamp=<unix-timestamp>
```

Response

```
{
  "status": 200,
  "value": {
    "value": "Live Test - 1",
    "ts": 1465233310
  }
}
```

- - -

#### Note
All the code for adding key value and retrieving key value based on timestamp version can be found in - [store.rb](https://github.com/taher435/key-value-store/blob/master/app/models/store.rb)

Unit tests for the model can be found in - [store_spec.rb](https://github.com/taher435/key-value-store/blob/master/spec/store_spec.rb)