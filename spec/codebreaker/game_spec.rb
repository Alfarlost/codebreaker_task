require 'spec_helper'

module Codebreaker
	describe Game do
	  let(:game) { Game.new }
      
      before do
      	game.start
      end

    context "#start" do
      it "saves secret code" do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      it "saves 4 numbers secret code" do
        expect(game.instance_variable_get(:@secret_code)).to have(4).items
      end
      it "saves secret code with numbers from 1 to 6" do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end
    end

    context "#propose_guess" do
      it "returns string" do
        answer = game.propose_guess("6331")
        expect(answer).not_to be_empty
      end
      
      it "raises exception if wrong input appear" do
        expect{game.propose_guess('a123')}.to raise_error(ArgumentError)
        expect{game.propose_guess("12334")}.to raise_error(ArgumentError)
      end

      it "returns 4 + if game won" do
        game.instance_variable_set(:@secret_code, "1234")
        answer1 = game.propose_guess("1234")
        
        expect(answer1).to eql("++++")
      end

      it "returns right output string" do
        game.instance_variable_set(:@secret_code, "1234")
        answer1 = game.propose_guess("4635")
        answer2 = game.propose_guess("5566")

        expect(answer1).to eql("-+")
        expect(answer2).to eql("No hit at all. What a shame!")
      end
    end
      
    context "#hint" do
      it "open 1 more number of code" do
        game.instance_variable_set(:@secret_code, "1234")
        answer1 = game.hint
        answer2 = game.hint
        answer3 = game.hint
        answer4 = game.hint

        expect(answer1).to eql("1***")
        expect(answer2).to eql("12**")
        expect(answer3).to eql("123*")
        expect(answer4).to eql("1234")
      end
    end
  
    context "#save_player_score_to" do
      it "should create 'filename' and put 'text' in it" do
        file = double
        File = double

        expect(File).to receive(:open).with("db.yaml", "w").and_yield(file)
        expect(file).to receive(:puts).with("--- !ruby/object:Player\nplayer_name: anonimus\nplayer_score: 0\n")

        game.save_player_score_to('db.yaml')
      end
    end
    
    context "#set_current_player_name" do
      it "should save user name" do
        game.set_current_player_name("Alfar")
        player = game.instance_variable_get(:@current_player)

        expect(player.name).to eql("Alfar")
      end
    end
  end
end 