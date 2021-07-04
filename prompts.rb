require 'terminal-table'

class Prompts
  def print_table(players)
    table = Terminal::Table.new
    table.title = 'Welcome to the amazing bowling alley!'
    table.headings = %w[Frame 1 2 3 4 5 6 7 8 9 10]
    table.rows = fill_rows(players)
    table.style = { all_separators: true, alignment: :center }
    puts table
  end

  private

  def fill_rows(players)
    names = players.keys
    rows_final = []
    names.each do |name|
      print_name = [name]
      print_pinfalls = %w[Pinfalls]
      players[name][:score].push('Score')
      loop_into_vectors(players[name], print_name, print_pinfalls)
      rows_final.push(print_name, print_pinfalls, players[name][:score])
    end
    rows_final
  end

  def loop_into_vectors(player, print_name, print_pinfalls)
    total_score = 0
    (1..10).each { |_| print_name.push('') }
    player[:rounds].each_with_index do |round, index|
      total_score += sum_points(player, round, index)
      print_pinfalls.push(round.join('  '))
      player[:score].push(total_score)
    end
  end

  def sum_points(player, round, index)
    next_first_round = find_next_first_round(player, index)
    next_second_round = find_next_second_round(player, index)
    if round.include?(10) && index < 9
      validate_with_strike(player, round, next_first_round, next_second_round, index)
    elsif round.inject(:+) == 10 && !round.include?(10) && index < 9
      validate_with_spare(round, next_first_round)
    else
      round.inject(:+)
    end
  end

  def find_next_first_round(player, index)
    index + 1 <= 9 ? player[:rounds][index + 1] : []
  end

  def find_next_second_round(player, index)
    index + 2 <= 9 ? player[:rounds][index + 2] : []
  end

  def validate_with_strike(player, round, next_first_round, next_second_round, index)
    auxiliary_score = 0
    auxiliary_score += validate_with_strike_two_rounds(round, next_first_round, next_second_round)
    auxiliary_score += validate_with_strike_next_round(round, next_first_round, index)
    auxiliary_score += validate_with_strike_last_round(player, round, index)
    auxiliary_score
  end

  def validate_with_strike_two_rounds(round, next_first_round, next_second_round)
    return 0 unless next_first_round[0] && next_second_round[0] && next_first_round[0] == 10

    round.inject(:+) + next_first_round[0] + next_second_round[0]
  end

  def validate_with_strike_next_round(round, next_first_round, index)
    return 0 unless next_first_round[0] && next_first_round[0] != 10 && index < 8

    round.inject(:+) + next_first_round.inject(:+)
  end

  def validate_with_strike_last_round(player, round, index)
    last_round = index + 1 == 9 ? player[:rounds].last : []

    return 0 unless last_round[0] && last_round[1]

    round.inject(:+) + last_round[0] + last_round[1]
  end

  def validate_with_spare(round, next_first_round)
    return 0 unless next_first_round[0]

    round.inject(:+) + next_first_round[0]
  end
end
