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
class Spree_products < ActiveRecord::Base
end

class App
  require './fileProcess'
    def initialize (arg)
      Spreadsheet.client_encoding = 'UTF-8'
      @filePath = arg
    end

    def getFilesNames (*path)
      @filePath = path[0] if (path.length != 0)

      resFileNames = []
      Find.find(@filePath).each do |file|
        resFileNames.push file if (file =~ /\b.xls$\b/)
      end
      return resFileNames
    end

    def process ()
      files = getFilesNames()
      files && files.each do |itemPath|
        file = FileProcessor.new( itemPath, 0, ['Instamart ID','Product Name', 'Weight/ Volume'] )
        file.process()
        file.close()
      end
    end
end

#run app for dir
app = App.new( "current/" )
app.process()

