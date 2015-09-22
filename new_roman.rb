hash = { 'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50 ,'C' => 100,'D' => 500, 'M' => 1000 }
test_hash = {}
def check_ixcm?(char, number, hash)
  count = 0
  flag = true
  number.each_char.with_index do |ch,index|
    ch == char ? count +=1 : count = 0
    if index < number.length - 1 && count == 3
      if hash[ch] > hash[number[index+1]]
        flag = true
      else
        return false
      end
    elsif (ch == 'I' || ch == 'X' || ch == 'C') && count == 2 && index < number.length - 1
      return false if hash[number[index+1]] > 1
    end
  end
  return true
end

def get_possible_sub(char)
  array = []
  case char
  when 'I' then
    array << 'V' << 'X'
  when 'X' then
    array << 'L' << 'C'
  when 'C' then
    array << 'D' << 'M'
  else
    puts "#{char} Can not substracted !! [** condition]"
    return array
  end
  return array
end

def calculate(number,hash)
  stack = []
  flag = true
  max = hash[number[0]]
  number.each_char do |char|
    if char == 'D' || char == 'L' || char == 'V'
      if number.count(char) > 1 ? true : false
        puts "Invalid Romam number !!! #{char} can't appear more than once"
        flag = false
        break
      end
    else
      if !check_ixcm?(char, number, hash)
        flag = false
        puts "Invalid Romam number !!! "
        break
      end
    end
    if hash.has_key?(char)
      if stack.empty?
        stack << hash[char]
      elsif hash[char] <= stack[-1]
        stack << hash[char]
      elsif hash[char] > stack[-1]
        array = get_possible_sub(hash.key(stack[-1]))
        if array.include?(char)
          stack << hash[char] - stack.pop
          max = hash[char]
        elsif array.empty?
          flag = false
        else
          puts " Error : #{hash.key(stack[-1])} is substracted from #{array.inspect} only [** condition]"
          flag = false
          break
        end
      end
    else
      puts "Invalid Roman Number"
      flag = false
      break
    end
  end
  puts "Roman number is :#{stack.inject(:+)}" if flag
end

puts "Enter Roman Number :"
number = gets.chomp.upcase
calculate(number,hash)
puts "---------------------------------------------------------------------"

print "Enter how many test input :"
number = gets.chomp.to_i
for i in 1..number
  print "Enter #{i} Test input :"
  test_input = gets.chomp.upcase
  result = test_input.split(" ")
  result.delete_at(1)
  if hash.has_key?(result[1])
    hash[result[0]] = hash[result[1]]
  else
    puts "Invalid Test case"
    puts "valid : glob is I"
  end
end
p hash
puts "---------------------------------------------------------------------"

print "Enter how many creadit details :"
number = gets.chomp.to_i
for i in 1..number
  print "Enter #{i} Credit Input:"
  credit_input = gets.chomp.upcase
  result = credit_input.sub("CREDITS","").split(" ")
  result.delete_at(-2)
  max = 0
  results = 0
  flag = true
  for key in 0...result.length - 2
    if hash.include?(result[key])
      if hash[result[key]] > max
        results = hash[result[key]] - results
      else
        results += hash[result[key]]
      end
      max = hash[result[key]]
    else
      puts "!!!! Invalid Expression !!!!!"
      flag = false
      break
    end
  end
  if flag && !result.empty?
    hash[result[result.length - 2]] = result[-1].to_f / results
    test_hash[result[result.length - 2]] = result[-1].to_f / results
  else
    puts "!!!! Invalid Expression !!!!!"
  end
end
p hash
puts "---------------------------------------------------------------------"

print "Enter how many Expression :"
number = gets.chomp.to_i
for i in 1..number
  puts "Enter #{i}Expression "
  test_expression = gets.chomp.upcase
  result_array = []
  begin
    result_array = test_expression.slice(test_expression.index("IS")..-1).gsub("?","").sub("IS","").split(" ")
    max = 0
    result = 0
    for key in 0...result_array.length - 1
      if hash.include?(result_array[key])
        hash[result_array[key]] > max ?
        result = hash[result_array[key]] - result :
        result += hash[result_array[key]]
        max = hash[result_array[key]]
      else
        raise
      end
    end
    if test_hash.include?(result_array[-1])
      puts "#{result_array.join(" ").downcase} is #{result * hash[result_array[-1]]} Credits"
    else
      puts "#{result_array.join(" ").downcase} is #{result}"
    end
  rescue
    puts "I have no idea what you are talking about"
  end
end
