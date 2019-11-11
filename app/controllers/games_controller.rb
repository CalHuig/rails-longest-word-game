require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times do
      letter = alphabet.sample.capitalize
      @letters << letter
    end
  end

  def score
    @user_word = params[:word].upcase
    @grid = params[:letters].upcase

    user_array = @user_word.split("")
    grid_array = @grid.split("")

    @message = ""

    url = "https://wagon-dictionary.herokuapp.com/#{@user_word}"
    the_word = JSON.parse(open(url).read)
    if user_array.all? { |letter| user_array.count(letter) <= grid_array.count(letter)} == false
      @message = "Please use only the letter we provide!"
    elsif the_word["found"] == false
      @message = "Are you sure your word exists in the english language?"
    else
      @message = "Well done! This is a valid english word!"
    end
  end
end
