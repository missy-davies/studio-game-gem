require 'studio_game/game'

module StudioGame
  describe Game do
    before do
      $stdout = StringIO.new # This prevents the puts from showing in console.

      @game = Game.new("Knuckleheads")

      @initial_health = 100
      @player = Player.new("moe", @initial_health)
      @rounds = 200

      @game.add_player(@player)
    end

    it 'w00ts the player if a high number is rolled' do
      Die.any_instance.stub(:roll).and_return(5)

      @game.play(@rounds)

      @player.health.should == @initial_health + (15 * @rounds)
    end

    it 'skips the player if a medium number is rolled' do
      Die.any_instance.stub(:roll).and_return(3)

      @game.play(@rounds)

      @player.health.should == @initial_health
    end

    it 'blams the player when a low number is rolled' do
      Die.any_instance.stub(:roll).and_return(1)

      @game.play(@rounds)

      @player.health.should == @initial_health - (10 * @rounds)
    end

    it "assigns a treasure for points during a player's turn" do
      game = Game.new("Knuckleheads")
      player = Player.new("moe")

      game.add_player(player)

      game.play(1)

      player.points.should_not be_zero

      # or use alternate expectation syntax:
      # expect(player.points).not_to be_zero
    end
  end
end
