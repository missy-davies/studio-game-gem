require_relative 'die'
require_relative 'player'
require_relative 'treasure_trove'
require_relative 'loaded_die'

module StudioGame
  module GameTurn
    def self.take_turn(player)
      number_rolled = Die.new.roll

      case number_rolled
      when 1..2
        player.blam
      when 3..4
        puts "#{player.name} was skipped."
      else
        player.w00t
      end

      treasure = TreasureTrove.random
      player.found_treasure(treasure)
    end
  end
end
