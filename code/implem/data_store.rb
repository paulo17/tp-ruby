class DataStore

  attr_accessor :available_models

  def initialize
    @available_models = []
    @stored = []
  end

  def register_model(name:, attributes:)
    @available_models << {name: name, attributes: attributes}
  end

  def models
    Array(@available_models.map { |hash| hash[:name] })
  end

  def save(model:, attributes:)
    pattern = @available_models.detect { |pattern| pattern[:name] == model }.dup

    attributes.each_key do |attribute|
      unless pattern[:attributes].include? attribute
        return @error_field = attribute.to_s
      end
    end

    @stored << Model.new(pattern, attributes)
  end

  def last(model)
    @stored.select { |pattern| pattern.name == model }.last
  end

  def count(model_name)
    @stored.select { |model| model.name == model_name }.count
  end

  def last_error
    @error_field ? "Invalid attribute: #{@error_field}" : nil
  end

end
