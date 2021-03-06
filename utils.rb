module Utils
  def convert_line(line)
    line.split(' ').map { |element| /\A\d+\Z/.match?(element) ? element.to_i : element }
  end

  def add_new_rounds(rounds, last_round, point)
    if last_round[0] == 10 && last_round.length == 1
      last_round.push(0)
      rounds.push([point])
    elsif last_round.length == 2
      rounds.push([point])
    else
      last_round.push(point)
    end
  end

  def add_last_round(player, last_round, point)
    last_round.push(point)
    player[:completed] = true if last_round[0] == 10 && last_round.length == 3
    player[:completed] = true if last_round[0] != 10 && last_round.length == 2
  end
end
