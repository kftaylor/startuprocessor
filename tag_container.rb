class TagContainer
  def initialize(original_value = nil)
    @original_value = original_value
    @tags = []
  end

  def add_tag(tag)
    @tags << tag if tag
  end

  def to_a
    @tags.flatten.compact.uniq.sort
  end

  def to_s
    @tags.empty? ? nil : to_a.join(', ')
  end

end