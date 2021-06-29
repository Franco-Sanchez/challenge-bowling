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

      unless @players[name][:completed]
        if @players[name][:rounds].empty?
          @players[name][:rounds].push([point])
        else
          last_round = @players[name][:rounds].last
          if @players[name][:rounds].rindex(last_round) == 9
            validate_last_round(last_round)
          else
            add_new_values(@players[name][:rounds], last_round)
          end
        end
      end
    end

    p @players
  end
end

Game.new.start
