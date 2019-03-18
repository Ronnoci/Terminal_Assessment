#This is a ruby gem which make the illastrations of the shuffled cards at the top of the game.

require 'rubycards'
include RubyCards

hand = Hand.new
deck = Deck.new

deck.shuffle!

hand.draw(deck, 3)

puts hand