require 'yaml'
require 'csv'


#for industry
array = CSV.foreach('docs/CCM.csv', col_sep: ',', headers: true).map do |a|
  [a['Industry'], {
                        industry: a['Industry Convert To'],
                        subindustry: a['Subindustry Convert To']
                    }
  ]
end

puts YAML.dump(Hash[array])



#for subindustry
array = CSV.foreach('docs/CCM2.csv', col_sep: ',', headers: true).map do |a|
  [a['Sub-Industry'], {
                        industry: a['Industry Convert To'],
                        subindustry: a['Subindustry Convert To']
                    }
  ]
end

puts YAML.dump(Hash[array])