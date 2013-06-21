require "../../app/parse/script"
require "test/unit"

class TestSimpleNumber < Test::Unit::TestCase
  def setup
    @app = App.new
  end

  def test_simple
    puts "next step checking number of excel files "
    @files = @app.getFiles( "../../app/parse/current/" )
    assert_equal(1, @files.length, "Number of xls files should be 1" )
  end

  def test_failure2
    puts
    @file = @files[0]
    assert_equal('hello', "hello", "Adding doesn't work" )
  end

end


#@files && @files.each do |filePath|
#  xls  = fileProcessor.getXLS( filePath )
#  xls.sheets.each do |sheet|
#    params = fileProcessor.getCurrentParams( xls, sheet )
#    titles = fileProcessor.getCurrentAttrNames( xls, sheet, params )
#
#    for index in params['startY'] + 1 .. params['endY']
#      #fileProcessor.parseAndSaveRow( xls, titles, index, params['startX'] )
#    end
#  end
