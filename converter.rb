require 'yaml'

class Converter
  def self.convert(yaml_file, key, industry, subindustry)
    map = YAML.load(File.open(yaml_file))
    if map.has_key?(key)
      conversion = map[key]
      industry.add_tag(conversion[:industry])
      subindustry.add_tag(conversion[:subindustry])
    end
  end
end