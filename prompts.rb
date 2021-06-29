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
      print_score = %w[Score]
      loop_into_vectors(players[name], print_name, print_pinfalls, print_score)
      rows_final.push(print_name, print_pinfalls, print_score)
    end
    rows_final
  end

  def loop_into_vectors(player, print_name, print_pinfalls, print_score)
    total_score = 0
    (1..10).each { |_| print_name.push('') }
    player[:rounds].each do |round|
      total_score += round.inject do |sum, element|
        element = 0 unless element.is_a? Integer
        sum + element
      end
      print_pinfalls.push(round.join('  '))
      print_score.push(total_score)
    end
  end
end
