require './lib/parser'

class App
  def initialize(file)
    @parser = Parser.new(File.read(file))
  end

  def run
    @parser.run
    print_games
    print_ranking
  end

  def print_games
    @parser.games.each do |game|
      puts game if game
    end
  end

  def print_ranking
    scores = Hash.new(0)
    @parser.games.each do |game|
      scores.update(game.kills) { |key, oldval, newval| scores[key] = oldval + newval } if game
    end

    ranking = {}
    scores.sort_by { |_key, value| -value }.each do |key, value|
      ranking[key] = value
    end
    puts 'global_ranking: ' + JSON.pretty_generate(ranking) + "\n"
  end

  m = App.new('./log/quake.log')
  m.run
end
