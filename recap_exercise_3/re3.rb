require 'byebug'
def no_dupes?(arr)
  h = Hash.new(0)
  arr.each{|e| h[e] += 1}
  h.select{|k,v| v==1}.keys
end

# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
  (0...arr.length - 1).each{|i|  return false if arr[i]==arr[i+1]}
  true
end

# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
  h = Hash.new{|h,k| h[k]=[]}
  str.chars.each_with_index{|c,i| h[c]<<i}
  h
end

# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
  current_char = longest_char = str[0]
  current_count = longest_count = 1
  i = 1

  while i<str.length
    current_count += 1 if current_char == str[i]
    longest_count += 1 if longest_char == str[i]

    if current_char != str[i]
      current_char = str[i]
      current_count = 1
    end

    if current_count >= longest_count
      longest_char = current_char
      longest_count = current_count
    end

    i += 1
  end

  longest_char*longest_count
end

# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

def bi_prime?(num)
  factors = []
  (2...num).select{|n| factors << n if num%n==0}
  return true if factors.count==2
  return true if factors.count==1 && factors[0]**2==num
  false
end

# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false

def vigenere_cipher(message, keys)
  a = ('a'..'z').to_a
  k_length = keys.length
  message.chars.each_with_index do |c, i|
    offset = keys[i % k_length]
    message[i] = a[(a.index(message[i])+offset)%26]
  end
  message
end

# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
  vowel_idxs = str.chars.each_with_index.select{|c,i| 'aeiou'.include?(c)}
  v = vowel_idxs.map{|k,v| k}
  orginal_idx = vowel_idxs.map{|k,v| v}
  new_idx = orginal_idx.rotate
  v.each_with_index do |c, i|
    str[new_idx[i]] = c
  end
  str
end

# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"

class String
  def select(&prc)
    prc ||= Proc.new{|v| false}
    arr = []
    self.chars.each{|c| arr << c if prc.call(c)}
    arr.join('')
  end

  def map!(&prc)
    self.each_char.with_index do |c, i|
      # debugger
      self[i] = prc.call(c, i)
    end
  end
end

# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""

# word_1 = "Lovelace"
# word_1.map! do |ch|
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     # debugger
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"

def multiply(a,b)
  return 0 if a == 0
  return b if a == 1

  return b + multiply(a - 1, b) if a > 0
  return -b + multiply(a + 1, b) if a < 0\
end

# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18

def lucas_sequence(n)
  return [] if n == 0
  return [2] if n == 1
  return [2, 1] if n==2
  lucas_sequence(n-1) + [lucas_sequence(n-1)[-1] + lucas_sequence(n-2)[-1]]
end

# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

def prime_factorization(num)
  return [] if num == 1
  p = (2..num).select{|n| num%n==0}.first
  [p] + prime_factorization(num/p)
end

# p prime_factorization(2)     # => [2]
# p prime_factorization(6)     # => [2, 2]
# p prime_factorization(12)     # => [2, 2, 3]
# p prime_factorization(24)     # => [2, 2, 2, 3]
# p prime_factorization(25)     # => [5, 5]
# p prime_factorization(60)     # => [2, 2, 3, 5]
# p prime_factorization(7)      # => [7]
# p prime_factorization(11)     # => [11]
# p prime_factorization(2017)   # => [2017]
