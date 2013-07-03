 require 'rubygems'
 require 'iconv'
 require 'roo'
 #require 'spreadsheet'


 HOURLY_RATE = 123.45

   oo = Roo::Spreadsheet#.open("1.xls")
   oo.default_sheet = oo.sheets.first
   4.upto(12) do |line|
   date       = oo.cell(line,'A')
   start_time = oo.cell(line,'B')
   end_time   = oo.cell(line,'C')
   pause      = oo.cell(line,'D')
   sum        = (end_time - start_time) - pause
   comment    = oo.cell(line,'F')
   amount     = sum * HOURLY_RATE
   if date
     puts "#{date}\t#{sum}\t#{amount}\t#{comment}"
   end
 end
