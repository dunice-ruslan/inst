require 'find'
require 'roo'
require 'spreadsheet'
a = Aaas.all
#b = Aaas.new({
#  name: "hello"
#})
b = Aaas.new
b.name = "heeeeeeeeeeeeeeeeee"
b.save!


  a = {
    b: "hi",
    c: "he"
  }
  d = "hello"
  a["hello"] = "gest"
  a[d] = "test"
	puts a, a[d]
	
	      startX : xls.first_row
    , startY : xls.first_column
    , endX   : xls.last_row
    , endY   : xls.last_column
	
	
	
      startX : @xls.first_row
    , startY : @xls.first_column
    , endX   : @xls.last_row
    , endY   : @xls.last_column
    
class FileModel
  def initialize(*args)
		@file_path = args[0]
		@data = []
		@xls = Roo::Spreadsheet.open(@file_path)
		puts @xls.first_row 
		puts "file initialized: " , @file_path
  end

	def parse
    @xls.sheets.each do |sheet|
			parse_a_sheet(sheet)
    end

		return true
		
	end

	def parse_a_sheet (sheet)
      @xls.default_sheet = sheet
			@xls.last_row && 0.upto(@xls.last_row) do |i|
				@data[i] = []
				@xls.last_column && 0.upto(@xls.last_column) do |j|
					@data[i].push( @xls.cell(i, j) )
					puts @xls.cell(i, j)," i::"+i.to_s+", j::"+j.to_s
				end
			end

	end


	def save
		puts "save"
	end
end


class Parse #< ActiveRecord::Base
	Spreadsheet.client_encoding = 'UTF-8'

  def initialize(*args)
		puts "initialized"
  end

	def getFiles (dir)
		result = []
		Find.find(dir) do |file| 
			if file =~ /\b.xls$\b/			
				result.push(file)
			end 
		end 
		return result
	end

end

p = Parse.new
files = p.getFiles("/home/kk/inst/app/parse/current/") 

files.each do |file_path|
	puts file_path
	file = FileModel.new(file_path)
	#a = file.parse
	#file.save



end
