# frozen_string_literal: true

require_relative 'game'
# class created for parsing
class Parser
  attr_accessor :log, :games

  WORLD = '1022'

  def initialize(log)
    @log = log
    @counter = 0
    @games = []
  end

  def start_game
    @games[@counter += 1] = Game.new(@counter)
    @map = {}
    @map[WORLD] = '<world>'
  end

  def run
    lines = @log.split("\n")
    lines.each do |line|
      parse_line(line)
    end
  end

  def parse_line(line)
    pattern = /\d+:\d+ \w+:/
    match = pattern.match(line)
    task = match.to_s.split(' ')[1]

    if task == 'InitGame:'
      start_game
    elsif task == 'ClientUserinfoChanged:'
      parse_update(match.post_match)
    elsif task == 'Kill:'
      parse_kill(match.post_match)
    elsif task == 'ClientDisconnect:'
      id = match.post_match.match(/\d+/).to_s
      @map[id] = nil
    end
  end

  def parse_update(data)
    id = data.match(/\d+/).to_s
    post_id = data.match(/\d+/).post_match.to_s
    name = post_id.match(/\\.*?\\/).to_s

    name = name[1..name.length - 2]

    if @map[id]
      @games[@counter].change_player_name(@map[id], name)
    else
      @games[@counter].new_player(name)
    end
    @map[id] = name
  end

  def parse_kill(data)
    ids = data.match(/\d+ \d+ \d+/).to_s.split(' ')
    if ids[0] == WORLD
      @games[@counter].world_kill(@map[ids[1]], ids[2])
    else
      @games[@counter].kill(@map[ids[0]], ids[2])
    end
  end
end
