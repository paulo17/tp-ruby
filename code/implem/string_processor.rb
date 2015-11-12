class StringProcessor

  def self.count(string, occurrence = nil)
    if occurrence.nil?
      string.size
    else
      string.downcase.count(occurrence.downcase)
    end
  end

  def self.concat(string1, string2)
    string1 + ' ' + string2
  end

end