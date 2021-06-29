require_relative 'utils'

class Game
  include Utils

  def initialize
    @players = {}
  end

  def start
    text_file = ARGV.first

    File.foreach(text_file) do |line|
      name, point = convert_line(line)
      point = 0 if point == 'F'
      next if point.negative? || point > 10

      @players[name] = { rounds: [], completed: false } if @players[name].nil?

      validate_completed(@players[name], @players[name][:rounds], point)
    end

    p @players
  end

  private

  def validate_completed(player, rounds, point)
    return if player[:completed]

    if rounds.empty?
      rounds.push([point])
    else
      if_not_empty(player, rounds, point)
    end
  end

  def if_not_empty(player, rounds, point)
    last_round = rounds.last
    if rounds.rindex(last_round) == 9
      add_last_round(player, last_round, point)
    else
      add_new_rounds(rounds, last_round, point)
    end
  end
end

Game.new.start
