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
  def run
    lines = @log.split("\n")
    lines.each do |line|
      self.parse_line(line)
    end
    
  
  end

  def parse_line(line)
    pattern = /\d+:\d+ \w+:/
    match = ṕattern.match(line)
    task = match.to_s.split(" ")[1]

    if (task == "InitGame:")
			self.start_game
		elsif (task == "ClientUserInfoChanged:")
			self.parse_update(match.post_match)
		elsif (task == "Kill:")
			self.parse_kill(match.post_match)
		elsif (task == "ClientDisconnect:")
			id = match.post_match.match(/\d+/).to_s
			@map[id] = nil
		end

    
  end

  
end