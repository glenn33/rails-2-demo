require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    word = params[:word]
    grid = params[:letters].split
    @result = ''
    return @result = "Sorry but #{word} cant be built of #{params[:letters]}" if word.split.sort == grid.sort   
    word_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
    hash_word = JSON.parse(word_serialized)
    if hash_word["found"]
      @result = "Congratulations! #{word} is a valid english word!"
    else
      @result = "Sorry but #{word} does not seem to be a valid english word!"
    end
  end
end