require 'parser'

RSpec.describe Parser, "log" do
  it "should receive the log in the constructor " do
    parser = Parser.new("---------")
    expect(parser.log).to eq "--------"
  end
end

RSpec.describe Parser, "games" do
  it "should start as an empty array" do
    parser = Parser.new("----------")
    expect(parser.games).to eq []
  end
end

RSpec.describe Parser, "parse_update" do
  it "parses a line with a ClientUserInfoChangedCommand" do
    parser = Parser.new("")
    parser.start_game
    parser.parse_update("2 \\Isgalamido\\tblablabla")
    expect(parser.instance_variable_get(:@map)).to eq ({"1022" => "<world>", "2" => "Isgalamido"})
    parser.parse_update("2 n\\Joao\\tblablabla")
    expect(parser.instance_variable_get(:@map)).to eq( {"1022" => "<world>", "2" => "Joao"})
  end
end