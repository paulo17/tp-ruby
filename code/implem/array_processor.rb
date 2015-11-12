class ArrayProcessor

  attr_accessor :my_array

  def initialize(array)
    @my_array = array
  end

  def self.sort(array)
    array.sort
  end

  def my_array_sorted
    self.class.sort @my_array
  end

  def contains?(value)
    @my_array.include? value
  end

  def self.double(array)
    double_array = []
    array.each do |value|
      double_array.push(value.to_s + value.to_s)
    end
    return double_array
  end

end