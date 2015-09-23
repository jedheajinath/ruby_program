hash = { 'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50 ,'C' => 100,'D' => 500, 'M' => 1000 }
new_roman_hash = {}

def check_ixcm?(char, number, hash)
  count = 0
  flag = true
  number.each_with_index do |ch,index|
    ch == char ? count +=1 : count = 0
    if index < number.length - 1 && count == 3
      if hash[ch] > hash[number[index+1]]
        flag = true
      else
        return false
      end
    elsif (ch == 'I' || ch == 'X' || ch == 'C') && count == 2 && index < number.length - 1
      return false if hash[number[index+1]] > hash[number[index]]
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

def calculate(number,hash,new_roman_hash)
  stack = []
  flag = true
  max = hash[number[0]]
  number.each do |char|
    if char == 'D' ||  char == 'L' || char == 'V'
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
    end
  end

  if flag
    # puts "Roman number is :#{stack.inject(:+)}"
    return stack.inject(:+)
  else
    return false
  end
end


def get_test_input(hash, new_roman_hash)
  print "Enter how many test input :"
  number = gets.chomp.to_i
  for i in 1..number
    print "Enter #{i} Test input :"
    test_input = gets.chomp.upcase

    begin
      test_input_array = test_input.split(" ")
      test_input_array.delete_at(1)
      if test_input_array.length > 2
        raise "Please Enter Roman number"
      # check if key is alerady exist new new roman
      elsif new_roman_hash.key?(test_input_array.first)
        raise "#{test_input_array.first} alerady exist !! "
      # check if value is alerady exist new new roman
      elsif new_roman_hash.has_value?(test_input_array.last)
        raise "value #{test_input_array.last} alerady taken !! "
      # check if key is alerady exist roman number
      elsif hash.has_key?(test_input_array.last)
        hash[test_input_array.first] = hash[test_input_array.last]
      # new_roman_hash[test_input_array.first] = new_roman_hash[test_input_array.last]
      else
        raise "Invalid input !!"
      end
    rescue Exception => e
      puts "#{e.message}"
      puts "Invalid Test case"
      puts "valid : glob is I"
    end
  end
end

def get_credits_details(hash,new_roman_hash)
  print "Enter how many creadit details :"
  number = gets.chomp.to_i
  for i in 1..number
    print "Enter #{i} Credit Input:"
    credit_input = gets.chomp.upcase
    begin
      credit_array = credit_input.sub("CREDITS","").split(" ")
      credit_array.delete_at(-2)
      credit_result = 0
      if credit_array.length < 1
        raise "Invalid Input"
      # if credits array has only 2 elements
    elsif credit_array.length == 2 && !hash.has_key?(credit_array.first)
      hash[credit_array.first] = credit_array.last
      new_roman_hash[credit_array.first] = credit_array.last
    else
        # get key and value to calculate
        result_val = credit_array.pop.to_i
        result_key = credit_array.pop
        # check if all the element exist
        if credit_array.uniq == (hash.keys & credit_array.uniq)
          # calculate roman number
          temp = calculate(credit_array,hash,new_roman_hash)
          if !temp
            raise " Invalid roman number "
          else
            # calculate result
            credit_result = result_val/temp
            hash[result_key] = credit_result
            new_roman_hash[result_key] = credit_result
            p hash
          end
        else
          raise "Invalid input ......."
        end
      end
    rescue Exception => e
      puts "#{e.message}"
    end
  end
end

def calculate_expression(hash,new_roman_hash)
  print "Enter how many Expression :"
  number = gets.chomp.to_i
  for i in 1..number
    puts "Enter #{i} Expression "
    test_expression = gets.chomp.upcase
    result_array = []
    begin
      result_array = test_expression.slice(test_expression.index("IS")..-1).
      gsub("?","").sub("IS","").split(" ")

      if new_roman_hash.has_key?(result_array.last)
        temp = hash[result_array.pop]
        result = calculate(result_array,hash,new_roman_hash)
        # raise exception if invalid roman number
        if result
          puts "#{result_array.join(" ").downcase} is #{result * temp } Credits"
        else
          raise
        end
      else
        result = calculate(result_array,hash,new_roman_hash)
        # raise exception if invalid roman number
        if result
          puts "#{result_array.join(" ").downcase} is #{result}"
        else
          raise
        end
      end
    rescue
      puts "I have no idea what you are talking about"
    end
  end
end

loop do
  sleep 0.1
  puts "1. Roman to Decimal Conversion"
  puts "2. Get Test Input"
  puts "3. Get Credit Details"
  puts "4. Solve Expression"
  puts "5. Display Roman number "
  puts "6. Exit"
  puts "-----------------------------------------------------------------------"
  print "Enter you choice :"
  choice = gets.chomp.to_i
  case choice
  when 1 then
    print "Enter Roman Number :"
    number = gets.chomp.upcase.split("")
    result = calculate(number,hash,new_roman_hash)
    puts "Roman number is : #{result}" if result
    puts "---------------------------------------------------------------------"
  when 2
    get_test_input(hash,new_roman_hash)
     puts "---------------------------------------------------------------------"
  when 3
    get_credits_details(hash,new_roman_hash)
     puts "---------------------------------------------------------------------"
  when 4
    calculate_expression(hash,new_roman_hash)
     puts "---------------------------------------------------------------------"
  when 5
    p hash
    puts "---------------------------------------------------------------------"
  when 6 then break
  else
    puts "Please Provide valid Input .."
    puts "-----------------------------------"
  end
end
