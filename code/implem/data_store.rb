class DataStore

  attr_accessor :available_models

  def initialize
    @available_models = []
  end

  def register_model(name:, attributes)
    @available_models << { name: name, attributes: attributes }
  end

  def models
    Array(@available_models.map { |hash| hash[:name] })
  end

  def save(model:, attributes)

  end

  def last(model)

  end

end
