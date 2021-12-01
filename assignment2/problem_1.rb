
def get_number(letter)
  num = letter.ord - "A".ord + 1
  value = 0
  1.upto(num) { |i| value = value * 2 + i }
  value
end

def get_sum(word)
  sum = 0
  word.each_char do |letter|
    sum += get_number(letter)
  end
  sum
end

def get_string(number)
  series = []
  value = 0
  1.upto(26) do |i|
    value = value*2 + i
    series << value
  end

  result = ""
  series.reverse.each_with_index do |value, i|
    if number < value
      next
    else
      count = number/value
      number = number%value
      count.times { result << (90-i).chr}
    end
  end
  result
end

p get_number("C")
p get_sum("GREP")
p get_string(3005110)

