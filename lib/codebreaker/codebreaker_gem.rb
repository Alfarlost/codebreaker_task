require "yaml"
require_relative "version.rb"
require_relative "player.rb"

module Codebreaker
  class Game
    def initialize
      @secret_code = ""
    end
 
    def start
      @current_player = Player.new
      @hints_used = 0
      @hints_left = 4
      randomize
    end

    def randomize
      4.times do
        @secret_code += rand(1..6).to_s
      end
    end

    def propose_guess(user_guess)
      raise ArgumentError.new unless user_guess.size == 4
      raise ArgumentError.new unless user_guess.match(/^\d+$/)

      answer = ""
      user_guess.chars.each_with_index do |ch, index|
        if ch == @secret_code[index]
          answer += '+'
        elsif @secret_code.include? ch
          answer += '-'
        end
      end
      answer << "No hit at all. What a shame!" if answer.empty?
      return answer
    end

    def hint 
      answer = ""
      @hints_used += 1 if @hints_used < 4
      @hints_left -= 1 if @hints_left > 0
      @hints_used.times do |i|
        answer << @secret_code[i]
      end
      @hints_left.times do |t|
        answer << "*"
      end
      return answer
    end
    
    def save_player_score_to(file)
      File.open(file, 'w') { |file| file.puts(@current_player.to_yaml) }
    end

    def set_current_player_name(name)
      @current_player.name = name
    end

    def get_current_player_name
      @current_player.name
    end

  end
end
