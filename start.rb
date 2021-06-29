text_file = ARGV.first

p text_file

player = {}

File.foreach(text_file) do |line|
  name, point = line.split(' ').map { |element| /\A\d+\Z/.match?(element) ? element.to_i : element }
  point = 0 if point == 'F'
  next if point.negative? || point > 10

  p name
  p point

end
