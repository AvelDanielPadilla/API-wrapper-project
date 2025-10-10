
# RAILS API WRAPPER W/ REST CLIENT GEM

This is a small project tasked by Avion (tech school) showcasing API wrapper using public API and making custom end points for non existent path. API used for this project was from https://the-one-api.dev/.

It lists the books, chapters, characters, quotes and movie franchise in a JSON format.


## API Reference
*All routes must be prefixed with https://the-one-api.dev/v2.* - https://the-one-api.dev/documentation
#### Get all books

```http
  GET /api/book
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get all movies

```http
  GET /api/movie
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |



## Usage/Examples
HERE ARE SOME FEW EXAMPLES OF THE END POINT:

GET http://127.0.0.1:3000/api/v1/lotr/book //Without Bearer Auth
```javascript
{
    "code": "401 Yamete Kudastop!",
    "error": "Do not go further or you will feel the wrath of Gimli bubble butt twerknado!!!",
    "data": "*Gimli starts Twerking"
}
```
GET http://127.0.0.1:3000/api/v1/lotr/book //With Bearer Auth
```javascript
{
    "docs": [
        {
            "_id": "5cf5805fb53e011a64671582",
            "name": "The Fellowship Of The Ring"
        },
        {
            "_id": "5cf58077b53e011a64671583",
            "name": "The Two Towers"
        },
        {
            "_id": "5cf58080b53e011a64671584",
            "name": "The Return Of The King"
        }
    ],
    "total": 3,
    "limit": 1000,
    "offset": 0,
    "page": 1,
    "pages": 1
}

```
GET http://127.0.0.1:3000/api/v1/lotr/bad_route //Custom wrong path
```javascript
{
    "success": false,
    "message": "Not found."
}

```

## Documentation
    STEPS TAKEN 
1. rails new my-app --api

2. create folders under app - api>v1>lotr

3. under lotr create file client.rb, errors.rb, request.rb

4. under client.rb, set up methods (including custom endpoint for wrong path):
module V1::Lotr
  class Client
    def self.character
      Request.call(http_method: "get", endpoint: "/character")
    end

    def self.quote
      Request.call(http_method: "get", endpoint: "/quote")
    end

    def self.book
      Request.call(http_method: "get", endpoint: "/book")
    end

    def self.chapter
      Request.call(http_method: "get", endpoint: "/chapter")
    end

    def self.movie
      Request.call(http_method: "get", endpoint: "/movie")
    end

    def self.bad_route
      Request.call(http_method: "get", endpoint: "/wrong-path")
    end
  end
end
5. under request set up the TOKEN and BASE URL and implemeting how the endpoints
will show. Implemented error rescue as well using RestClient gem.

6. Create controller for path

7. under app>controller create folders api>v1>lotr.

8. under it create controller rb.

9. sample controller:
module Api::V1::Lotr
  class LotrController < ApplicationController
    def get_character
      response = V1::Lotr::Client::character
      render json: response
    end

    def get_quote
      response = V1::Lotr::Client::quote
      render json: response
    end

    def get_book
      response = V1::Lotr::Client::book
      render json: response
    end

    def get_chapter
      response = V1::Lotr::Client::chapter
      render json: response
    end

    def get_movie
      response = V1::Lotr::Client::movie
      render json: response
    end

    def get_error
      response =  V1::Lotr::Client::bad_route
      render json: response
    end
  end
end
10. under same app>controllers go to application_controller.rb to set up a callback function 
before_action :authenticate_api_key! to make sure that the error for 401 will trigger and make sure auth is required.

11. Under errors.rb in app>api>v1>lotr>errors.rb set up method for showing 404 response:
module V1::Lotr
  class Errors
    def self.map(code)
      case code
      when 404
        "Aragorn Baddics not available!"
      else
        "My precious!"
      end
    end
  end
end

12. set up routes under config>route.rb for endpoints to work in our wrapper:

13. set up .env for the TOKEN


## Tech Stack
**Server:** rails, postman

