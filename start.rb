player = {}

File.foreach('./attempts.txt') do |line|
  name, point = line.split(' ').map { |element| /\A\d+\Z/.match?(element) ? element.to_i : element }
  point = 0 if point == 'F'

  
end
