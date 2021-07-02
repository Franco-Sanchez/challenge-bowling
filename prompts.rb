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
      next_first_round = index + 1 <= 9 ? player[:rounds][index + 1] : []
      next_second_round = index + 2 <= 9 ? player[:rounds][index + 2] : []
      if round.include?(10) && index < 9
        last_round = index + 1 == 9 ? player[:rounds].last : []
        total_score += round.inject(:+) + next_first_round[0] + next_second_round[0] if next_first_round[0] && next_second_round[0] && next_first_round[0] == 10
        total_score += round.inject(:+) + next_first_round.inject(:+) if next_first_round[0] && next_first_round[0] != 10 && index < 8
        total_score += round.inject(:+) + last_round[0] + last_round[1] if last_round[0] && last_round[1]
      elsif round.inject(:+) == 10 && !round.include?(10) && index < 9
        total_score += round.inject(:+) + next_first_round[0] if next_first_round[0]
      else
        total_score += round.inject(:+)
      end
      print_pinfalls.push(round.join('  '))
      player[:score].push(total_score)
    end
  end
end
