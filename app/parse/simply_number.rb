require 'find'
require 'roo'
require 'spreadsheet'
require 'active_record'
require 'mysql2'


ActiveRecord::Base.establish_connection ({
    :adapter => "mysql",
    :host => "localhost",
    :username => "root",
    :password => "qq",
    :database => "spree"})

class Aaas < ActiveRecord::Base
end




#app   = App.new
#files = app.getFiles( "current/" )
#puts files[0]
#files && files.each do |filePath|
#  file = FileModel.new ( filePath )
#  xls  = file.getXLS()
#  xls.sheets.each do |sheet|
#    sheet  = file.setCurrentSheet( sheet )
#    params = file.getCurrentParams()
#    titles = file.getCurrentAttrNames()
#
#    for index in params['startY'] + 1 .. params['endY']
#      file.parseAndSaveRow( index )
#    end
#  end
#end

