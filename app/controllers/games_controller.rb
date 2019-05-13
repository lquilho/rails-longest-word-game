require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    abz = ('a'..'z').to_a
    (1..10).each { @letters << abz[rand(abz.length-1)].upcase }
    @letters
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split(' ')
    @word_in_grid = word_in_grid?(@word, @letters)
    @english = word_english?(@word)
  end

  def word_in_grid?(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end

  def word_english?(word)
    json = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    word_info = JSON.parse(json, symbolize_names: true)
    found = word_info[:found]
  end

end
