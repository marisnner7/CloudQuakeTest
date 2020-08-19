# frozen_string_literal: true

require 'game'

RSpec.describe Game '.kills' do
  it 'starts empty' do
    game = Game.new(0)
    expect(game.kills).to be_empty
  end

  it 'has value 0 as default for a key' do
    game = Game.new(0)
    game.new_player('Marianne')
    expect(game.kills['Marianne']).to eq 0
  end

  it "increases it's value whenever a key has a kill registered" do
    game = Game.new(0)
    game.new_player('Marianne')
    game.kill('Marianne', '0')
    expect(game.kills['Marianne']).to eq 1
    game.kill('Marianne', '0')
    expect(game.kills['Marianne']).to eq 2
  end

  it 'keeps the kills even when player changes name' do
    game = Game.new(0)
    game.new_player('Marianne')
    game.kill('Marianne', '0')
    game.kill('Marianne', '0')
    game.change_player_name('Marianne', 'Maria')
    expect(game.kills['Maria']).to eq 2
    expect(game.kills['Marianne']).to eq 0
  end

  it "decreases a player's score whenever a world_kill happens to him/her" do
    game = Game.new(0)
    game.new_player('Marianne')
    game.kill('Marianne', '0')
    expect(game.kills['Marianne']).to eq 1
    game.world_kill('Marianne', '0')
    expect(game.kills['Marianne']).to eq 0
    game.world_kill('Marianne', '0')
    expect(game.kills['Marianne']).to eq(-1)
  end
end

RSpec.describe Game 'total_kills' do
  it 'starts as 0' do
    game = Game.new(0)
    expect(game.instance_variable_get(:@total_kills)).to eq 0
  end

  it 'increases when someone is killed' do
    game = Game.new(0)
    game.new_player('Marianne')
    game.kill('Marianne', '0')
    expect(game.instance_variable_get(:@total_kills)).to eq 1
    game.kill('Marianne', '1')
    expect(game.instance_variable_get(:@total_kills)).to eq 2
    game.world_kill('Marianne', '2')
    expect(game.instance_variable_get(:@total_kills)).to eq 3
  end
end
