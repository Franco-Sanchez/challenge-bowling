module Utils
  def convert_line(line)
    line.split(' ').map { |element| /\A\d+\Z/.match?(element) ? element.to_i : element }
  end

  def add_new_rounds(rounds, last_round, point)
    last_round[0] == 10 || last_round.length == 2 ? rounds.push([point]) : last_round.push(point)
  end

  def add_last_round(player, last_round, point)
    last_round.push(point)
    player[:completed] = true if last_round[0] == 10 && last_round.length == 3
    player[:completed] = true if last_round[0] != 10 && last_round.length == 2
  end
end
