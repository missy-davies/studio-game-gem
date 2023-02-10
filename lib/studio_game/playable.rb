module StudioGame
  module Playable
    def w00t
      self.health += 15
      puts "#{name} got w00ted!"
    end

    def blam
      self.health -= 10
      puts "#{name} got blammed!"
    end

    def strong?
      if self.health >= 100
        true
      else
        false
      end
    end
  end
end
