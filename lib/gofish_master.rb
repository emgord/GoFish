require "rubycards"
include RubyCards
require "./lib/game"
require "./lib/player"


puts "Welcome to Go Fish!"
puts "How many players do you have today?"
# add validation to make sure you get an Int between 3 and 6
num_players = gets.chomp
game = GoFish::Game.new(num_players)
num_players.to_i.times do
  puts "What is your player name?"
  name = gets.chomp
  game.create_player(name)
end

game.players.each do |player|
  puts player.secret_hand
end
