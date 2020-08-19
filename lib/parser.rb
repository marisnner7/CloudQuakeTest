require_relative 'game'
class Parser
  attr_accessor :log, :games

  WORLD = "1022"

  def initialize(log)
    @log = log
    @counter = 0
    @games = []
    
  end

  def start_game
    @games[@counter += 1] = Game.new(@counter)
    @map = Hash.new
    @map[WORLD] = "<world>"
    
  end

  
end