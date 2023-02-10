require_relative 'player'
require_relative 'game_turn'
require_relative 'treasure_trove'

module StudioGame
  class Game
    attr_reader :title

    def initialize(title)
      @title = title.capitalize
      @players = []
    end

    def load_players(from_file = "players.csv")
      File.readlines(from_file).each do |line|
        add_player(Player.from_csv(line))
      end
    end

    def add_player(player)
      @players << player
    end

    def play(rounds)
      puts "There are #{@players.length} players in #{@title}:"

      @players.each do |player|
        puts player
      end

      treasures = TreasureTrove::TREASURES
      puts "\nThere are #{treasures.size} treasures to be found:"
      treasures.each { |treasure| puts "A #{treasure.name} is worth #{treasure.points} points." }

      1.upto(rounds) do |round|
        puts "\nRound #{round}"
        @players.each do |player|
          GameTurn.take_turn(player)
          puts player
        end
      end
    end

    def print_stats
      strong, wimpy = @players.partition { |player| player.strong? }

      puts "\n#{@title} Statistics:"
      puts "\n#{strong.size} strong players:"
      strong.each { |s| puts "#{s.name} (#{s.health})" }

      puts "\n#{wimpy.size} wimpy players:"
      wimpy.each { |w| puts "#{w.name} (#{w.health})" }

      puts "\n#{@title} High Scores:"
      @players.sort.each do |player|
        puts high_score_entry(player)
      end

      @players.sort.each do |player|
        puts "\n#{player.name}'s point totals:"

        player.each_found_treasure do |treasure|
          puts "#{treasure.points} total #{treasure.name} points"
        end

        puts "= #{player.points} GRAND TOTAL POINTS"
      end
    end

    def save_high_scores(to_file = "high_scores.txt")
      File.open(to_file, "w") do |f|
        f.write "#{@title} High Scores:\n"
        @players.sort.each do |player|
          f.puts high_score_entry(player)
        end
      end
    end

    def high_score_entry(player)
      "#{player.name.ljust(20, '.')} #{player.score}"
    end
  end
end

if __FILE__ == $0
  davies = StudioGame::Game.new("davies")

  player1 = StudioGame::Player.new("missy")
  player2 = StudioGame::Player.new("kyle")
  player3 = StudioGame::Player.new("kehley")
  player4 = StudioGame::Player.new("anne")

  davies.add_player(player1)
  davies.add_player(player2)
  davies.add_player(player3)
  davies.add_player(player4)

  davies.play(2)
end
