class CarSort

  def self.perform(array)
    colors = Hash.new 0
    colors = initialize_colors(array, colors)

    array.each_with_index do |value, index|
      if array[index + 1] == value
        colors[value.to_sym] += 1
      end
    end

    return colors.sort.to_h
  end

  private
  def self.initialize_colors(array, colors)
    array.each do |value|
      colors[value.to_sym] = 1
    end

    return colors
  end

end