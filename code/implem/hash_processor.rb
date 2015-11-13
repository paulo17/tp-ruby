class HashProcessor

  attr_accessor(:h)

  def initialize(attributes)
    @h = attributes
    @h_back = attributes.clone
  end

  def size
    @h.size
  end

  def merge(hash)
    @h.merge(hash)
  end

  def find(key)
    key_exist?(key) ? @h[key] : 'Unknown key, sorry'
  end

  def delete(key)
    @h[key] = nil if key_exist?(key)
  end

  def restore(key)
    @h[key] = @h_back[key] if key_exist?(key)
  end

  private
  def key_exist?(key)
    @h.has_key?(key)
  end

end