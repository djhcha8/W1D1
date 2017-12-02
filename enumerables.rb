require 'byebug'

class Array

  def my_each(&prc)
    idx = 0
    while idx < self.length
      prc.call(self[idx])
      idx += 1
    end
    self
  end

  def my_select(&prc)
    output = []
    self.my_each do |el|
      output << el if prc.call(el)
    end
    output
  end

  def my_reject(&prc)
    output = []
    self.my_each do |el|
      output << el if prc.call(el) == false
    end
    output
  end

  def my_flatten
    output = []
    self.my_each do |el|
      if el.class == Array
        output += el.my_flatten
      else
        output << el
      end
    end
    output
  end

  def my_zip(*args)
    output = []
    self.length.times do |idx|
      temp = []
      temp << self[idx]
      args.my_each do |arr|
        temp << arr[idx]
      end
      output << temp
    end
    output
  end

  def my_rotate(num)
    offset = num % self.length
    output = []
    output << self.drop(offset)
    output << self.take(offset)
    output.my_flatten
  end

  def my_join(separator = "")
    output = ""
    self.my_each do |el|
      output += el
      output += separator
    end
    output[0..(output.length - separator.length)-1]
  end

  def my_reverse
    output = []
    self.my_each do |el|
      output.unshift(el)
    end
    output
  end



end #class Array
