#encoding: utf-8
require 'csv'
require 'date'
require_relative 'target_row'

configure do
end

before do
end

get '/' do
  erb :form
end

post '/' do
  begin

    unless params[:file] && (tmpfile = params[:file][:tempfile])
      status 200
    end

    output = []
    CSV.new(tmpfile.read, :headers => true).each do |row|
      output << TargetRow.new(row).to_a
    end

    content_type 'application/csv'
    attachment 'output.csv'

    CSV.generate do |csv|
      csv << %w(Company URL Industry Sub-Industry City)
      output.each { |row| csv << row }
    end

  rescue => e
    logger.error e
    status 500
  end
end