require_relative 'codebreaker_gem.rb'

  class CodebreakerGame
  	include Codebreaker

  	  def start
  	  	 @game = Game.new
  	  	 @game.start
  	  	 @player_score = 100

  	  	 puts "We have secret code. Try to break it!"
  	  	 loop do
  	  	 	puts "Enter your propose!"

  	  	 	player_input = gets.strip
  	  	 	
  	  	 	case player_input
  	  	 	when "hint" then
  	  	 		puts @game.hint
            @player_score -= 30
  	  	 		next
  	  	 	when "exit" then
  	  	 		puts "Bye Bye!"
  	  	 		break
  	  	 	else
  	  	 		begin
  	  	 		answer = @game.propose_guess(player_input)
  	  	 		puts answer

  	  	 		if answer.include? "++++"
  	  	 		  @player_score += 100
  	  	 		elsif answer.include? "+"
  	  	 		  @player_score += 25
  	  	 		elsif answer.include? "++"
  	  	 		  @player_score += 50
  	  	 		elsif answer.include? "+++"
  	  	 		  @player_score += 75
  	  	 		elsif answer.include? "-"
  	  	 		  @player_score += 10
  	  	 		elsif answer.include? "--"
  	  	 		  @player_score += 20
  	  	 		elsif answer.include? "---"
  	  	 		  @player_score += 30
  	  	 		end 

  	  	 	rescue ArgumentError
  	  	 		puts "Maaan! Umad! Your code must be 4 numbers from 1 to 6!"
  	  	 		@player_score += 50
            end
          end
          @player_score -= 50

          if @player_score < 0 
            puts "Mhaha! You can' reach my code!"
            break
          elsif answer == "++++"
          	puts "You're awsome! I will rember you!"
          	puts "Just enter your name: "
          	@game.set_current_player_name(gets.strip)
          	@game.save_player_score_to("codebreaker_honorhall.yaml")
          	break
          end
        end

  	  end
   end  	 

   game = CodebreakerGame.new
   game.start