class Animal
  attr_accessor :name, :predators

  def initialize(name: nil)
    @predators = []
    @name = name
    @rage_mode = false
  end

  def predator?(animal)
    return false if @rage_mode || @predators.nil?
    @predators.include?(animal.class)
  end

  def enter_rage!
    @rage_mode = true
  end

  def exit_rage!
    @rage_mode = false
  end

end