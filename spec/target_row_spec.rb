require 'spec_helper'
require_relative '../target_row'
require 'csv'

RSpec.describe TargetRow do
  context 'happy path' do
    it 'parses first two columns' do
      data = {
          'Company' => 'TrueCar',
          'URL' => 'http://truecar.com',
          'City' => 'San Jose'
      }
      result = TargetRow.new(data).to_a
      expect(result[0]).to eq 'TrueCar'
      expect(result[1]).to eq 'http://truecar.com'
      expect(result.last).to eq 'San Jose'
    end

    it 'works for one row' do
      data = {
          'Company' => 'TrueCar',
          'URL' => 'http://truecar.com',
          'Sector' => 'Internet',
          'Industry' => 'Internet Software & Services',
          'Sub-Industry' => 'Information Providers & Portals',
          'City' => 'Santa Monica'
      }
      result = TargetRow.new(data).to_a
      expect(result).to match_array(['TrueCar', 'http://truecar.com', nil, 'Information Provider', 'Santa Monica'])
    end

    it 'works for another' do
      data = {
          'Company' => 'Gradient X',
          'URL' => 'http://gradientx.com',
          'Sector' => 'Mobile & Telecommunications',
          'Industry' => 'Mobile Software & Services',
          'Sub-Industry' => 'Advertising, Sales & Marketing',
          'City' =>  'Santa Monica'
      }
      result = TargetRow.new(data).to_a
      expect(result).to match_array(['Gradient X','http://gradientx.com',nil, 'Ad-Tech, Mobile, Sales & Marketing','Santa Monica'])
    end

    it 'works for this one too' do
      data = {
          'Company' => 'MiTu',
          'URL' => 'http://mituinc.com',
          'Sector' => 'Internet',
          'Industry' => 'Internet Software & Services',
          'Sub-Industry' => 'Video',
          'City' =>  'Culver City'
      }
      result = TargetRow.new(data).to_a
      expect(result).to match_array(['MiTu','http://mituinc.com','Digital Media','Video','Culver City'])
    end

    it 'works for a CSV file' do
      expected = CSV.read('examples/2/output.csv', headers: false)
      i = 1
      CSV.foreach('examples/2/input.csv', headers: true) do |row|
        t = TargetRow.new(row)
        expect(t.to_a).to match_array(expected[i])
        i += 1
      end
    end
  end
end