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