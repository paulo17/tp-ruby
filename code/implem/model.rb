class Model

  attr_accessor :name

  def initialize(pattern, data)
    @name = pattern[:name]
    @data = {}
    pattern[:attributes].each do |attribute|
      @data[attribute] = data[attribute]
    end
  end

  def method_missing(m, *args, &block)
    if @data.has_key? m
      @data[m]
    else
      'INVALID'
    end
  end

end