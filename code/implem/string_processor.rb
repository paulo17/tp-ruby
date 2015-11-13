class StringProcessor

  def self.count(string, occurrence = nil)
    occurrence.nil? ? string.size : string.downcase.count(occurrence.downcase)
  end

  def self.concat(string1, string2)
    string1 + ' ' + string2
  end

end