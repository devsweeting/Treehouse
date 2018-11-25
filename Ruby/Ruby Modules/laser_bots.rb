module LaserBots
  module Console
    class Command
    end
  end

  module World
    class Player
      attr_reader :name
      def initialize(name)
        @name = name
      end
    end
  end
end
