require './card_deck' #Displays the cards at the start of game
require 'colorize'  #Allows for colorization in the program

def legality    #Because it's a gambling game we need to ask if player is over 18

    puts "To play this awesome game you will need to be over the age of 18!"
    puts "Are you over 18 years old?
    #{'Yes'.green} or #{'No'.red}"

    age = gets.chomp
    case age
    when "yes"
        system("clear")
        puts "You may enter".green
    when "no"
        puts "Come back when youre older".red
        exit
    end
end

def startup  

    #starts startup loop
    loop do
            puts "Welcome to the game BLACKJACK!".on_blue
            puts "Type #{'1'.blue} to play"
            puts "Type #{'2'.blue} for how to play"
            puts "To end the game simply type #{'Q'.red}"
 
        input = gets.chomp

        case input
                when  "1"   #Time to play
                        system("clear")
                        puts "Let's play!"
                    break
                when  "2"   #Will show you how to play
                        puts "How to Play: The object of the game is to get 21 (Blackjack).
                        - You start off with 2 cards.
                        - Type 'Hit' for another card.
                        - Type 'Stay' to leave the amount you have.
                        - If you go over 21 then you are bust.
                        - You are playing against the dealer.
                        - Hit enter to proceed"
                        gets.chomp
                when "Q"    #Quits
                        puts "Goodbye".red
                        puts exit
        end
    end
end
 
def print_result(player, dealer)    #If neither Player nor Dealer busts or gets 21 then will compare who has highest card
    
    if player > dealer
        puts "You Win".black.on_green
    else 
        puts "You Lose".black.on_red
    end
end
     
def game

    #The cards used assigned with its value
    cards = { "Ace" => 11, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9, "10" => 10, "Jack" => 10, "Queen" => 10, "King" => 10 }
    
    #Players empty array for added cards
    player_hits = []
    card1 = cards.keys.sample   #Player card 1 - random
    card2 = cards.keys.sample   #Player card 2 - random
    # Deal Player 2 cards 
    player_hits << card1
    player_hits << card2 
    # Set Player total hand 
    player_total = player_hits.inject(0){|sum, key| sum + cards[key]}

    puts "Your first card is #{card1.green}, and your second card is #{card2.green}"
    # Players loop
    loop do
        puts "#{'Hit'.cyan} or #{'Stay'.cyan}"
        input = gets.chomp  #Allows Player to input Hit or Stay

        case input
            when "hit" #Will add another card to Player hand
                puts player_hits << cards.keys.sample #adds another random card
                player_total = player_hits.inject(0){|sum, key| sum + cards[key]}
                puts "Your total is:" + " #{player_total}".green #Displays Player total
                if player_total == 21 #If Player gets 21 then will still move onto Dealer
                    puts "BLACKJACK!".black.on_green
                    break
                elsif player_total > 21 #If Player gets over 21, Dealer wins, ends game
                    puts "Player busted. Dealer wins!".black.on_red
                    exit
                    end
            when  "stay" #Will not add another card to Player and will move onto Dealer
                puts player_hits
                puts "Your total is:" + " #{player_total}".green
                break
                    
            when "Q" #Quits
                puts "Goodbye".red
                exit
        end
    end   

    #Dealers empty array for added cards
    dealer_hits = []
    card3 = cards.keys.sample   #Dealer card 1 - random
    card4 = cards.keys.sample   #Dealer card 2 - random
    #Deal Dealer 2 cards
    dealer_hits << card3
    dealer_hits << card4
    #Set Dealer total hand
    dealer_total = dealer_hits.inject(0){|sum, key| sum + cards[key]}

    puts "Dealers first card is #{card3.red}, and second card is #{card4.red}"
    #Dealers loop
    loop do
        
        if dealer_total < 15 # HIT: Dealer will add another card if below 15
            card = cards.keys.sample #adds another random card
            dealer_hits << card
            puts dealer_hits #Displays  what cards dealer gets when hit
            dealer_total = dealer_hits.inject(0){|sum, key| sum + cards[key]}
            
        puts "Dealer hits and draws a: #{card.red}" #Displays total when hits
        elsif (dealer_total >= 15) && (dealer_total < 21) # STAY: Dealer will not add another card if above 15 and below 21
            puts "Dealers stands with total:" + " #{dealer_total}".red #Dispalys total when stands
            break
        elsif dealer_total == 21 #Dealer instantly wins if gets 21
            puts "Dealer BLACKJACK! You lose.".black.on_red
            exit
        else # BUST: Player wins if Dealer gets over 21 
            puts "Dealer busted. You win".black.on_green
            exit
        end
    end
    print_result(player_total, dealer_total) #Compares Dealers total and Players total if neither get blackjack or bust
end   


puts legality
puts startup
puts game

