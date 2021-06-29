module Utils
  def convert_line(line)
    line.split(' ').map { |element| /\A\d+\Z/.match?(element) ? element.to_i : element }
  end

  def add_new_values(rounds, last_round)
    last_round[0] == 10 || last_round.length == 2 ? rounds.push([point]) : last_round.push(point)
  end

  def validate_last_round(last_round)
    # 
  end
end
