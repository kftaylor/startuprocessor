require_relative 'tag_container'
require_relative 'converter'

class TargetRow


  def initialize(csv_row)
    @source = csv_row
    @industry = TagContainer.new
    @subindustry = TagContainer.new
  end

  def to_a
    result = []
    result << @source['Company']
    result << @source['URL']
    Converter.convert('sector.yaml', @source['Sector'], @industry, @subindustry)
    Converter.convert('industry.yaml', @source['Industry'], @industry, @subindustry)
    Converter.convert('subindustry.yaml', @source['Sub-Industry'], @industry, @subindustry)
    result << @industry.to_s
    result << @subindustry.to_s
    result << @source['City']
    result
  end

end