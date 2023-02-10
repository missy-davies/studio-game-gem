require "studio_game/player"

module StudioGame
  describe Player do
    before do
      $stdout = StringIO.new # This prevents the puts from showing in console.

      @initial_health = 150
      @player = Player.new('missy', @initial_health)
    end

    it "has a capitalized name" do
      @player.name.should == "Missy"
    end

    it "has an initial health" do
      @player.health.should == 150
    end

    it "has a string representation" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      @player.to_s.should == "I'm Missy with health = 150, points = 100, and score = 250."
    end

    it "computes a score as the sum of its health and points" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      @player.score.should == 250
    end

    it "increases health by 15 when w00ted" do
      @player.w00t

      @player.health.should == @initial_health + 15
    end

    it "decreases health by 10 when blammed" do
      @player.blam

      @player.health.should == @initial_health - 10
    end

    context "with health greater than 100" do
      before do
        @player = Player.new("Sally", 150)
      end

      it "is strong" do
        @player.should be_strong
      end
    end

    context "with health less than 100" do
      before do
        @player = Player.new("Joe", 80)
      end

      it "is not strong (is wimpy)" do
        @player.should_not be_strong
      end
    end

    context "in a collection of players" do
      before do
        @player1 = Player.new("moe", 100)
        @player2 = Player.new("larry", 200)
        @player3 = Player.new("curly", 300)

        @players = [@player1, @player2, @player3]
      end

      it "is sorted by decreasing score" do
        @players.sort.should == [@player3, @player2, @player1]
      end
    end

    it "computes points as the sum of all treasure points" do
      @player.points.should == 0

      @player.found_treasure(Treasure.new(:hammer, 50))

      @player.points.should == 50

      @player.found_treasure(Treasure.new(:crowbar, 400))

      @player.points.should == 450

      @player.found_treasure(Treasure.new(:hammer, 50))

      @player.points.should == 500
    end

    it "yields each found treasure and its total points" do
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))

      yielded = []
      @player.each_found_treasure do |treasure|
        yielded << treasure
      end

      yielded.should == [
        Treasure.new(:skillet, 200),
        Treasure.new(:hammer, 50),
        Treasure.new(:bottle, 25)
    ]
    end

    it "creates a player from a csv line entry" do
      line = "missy, 29"

      Player.from_csv(line).name.should == "Missy"
      Player.from_csv(line).health.should == 29
    end
  end
end
