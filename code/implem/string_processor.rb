class StringProcessor

  def self.count(string, occurrence = nil)
    if occurrence.nil?
      return string.size
    end
    string.downcase.count(occurrence.downcase)
  end

  def self.concat(string1, string2)
    string1 + ' ' + string2
  end

end