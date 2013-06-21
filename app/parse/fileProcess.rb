require 'spree'

class FileProcessor
  def initialize (arg, sheetIndex, arrIndexs)
    puts "INITTTTTTTTTTTTTTTTT"
    Spreadsheet.client_encoding = 'UTF-8'
    @filePath = arg
    @sheetIndex = sheetIndex
    @arrUsefullTitles = arrIndexs
    @arrUsefullTitles && @arrUsefullTitles = @arrUsefullTitles.map { |title| canonicalAttrName(title) }
  end

  def process
    xls = getXLS ( @filePath )
    xls.sheets.each_with_index do |sheet, index|
      if (@sheetIndex && @sheetIndex === index)
        params = getCurrentParams( xls, sheet )
        startX = params['startX']
        titles = getCurrentAttrNames( xls, sheet, params )
        for index in params['startY'] + 1 .. params['endY']
          parseAndSaveRow( xls, titles, index, startX)
        end
      end
    end
  end

  def close
    puts "close File"
  end


  def getXLS ( filePath )
    return Roo::Spreadsheet.open( filePath )
  end

  def getCurrentAttrNames ( xls, sheet, params )
    titles = {}
    return titles if ( params['startY'] < 0 )

    rowWithTitles = xls.row( params['startY'] )
    rowWithTitles.each_with_index do |title, index|
      titles[ index + params['startX'] ] = canonicalAttrName(title)
    end

    return titles
  end

  def getCurrentParams ( xls, sheet )
    xls.default_sheet = sheet
    params = {}
    params['startX'] = (xls.first_column.nil?) ? -1 : xls.first_column
    params['startY'] = (xls.first_row.nil?)    ? -1 : xls.first_row
    params['endX']   = (xls.last_column.nil?)  ? -1 : xls.last_column
    params['endY']   = (xls.last_row.nil?)     ? -1 : xls.last_row
    return params
  end

  def canonicalAttrName ( attrTitle )
    return 'instamart_id'        if (['Instamart ID'].include?( attrTitle ) )
    return 'name'       if (['Product Name'].include?( attrTitle ) )
    return 'description' if (['Weight/ Volume', 'Dog', 'Bird'].include?( attrTitle ) )
    return 'price'    if (['Metro Price per Item (RUR)'].include?( attrTitle ) )
    return 'another'
  end


  def parseAndSaveRow ( xls, titles, rowIndex, startX )
    return if ( rowIndex < 0 )
    rowForParse = xls.row( rowIndex )
    product     = Spree_products.new
    #product = {}
    rowForParse.each_with_index do |elem, index|
      attrName = titles[index + startX]
      if (@arrUsefullTitles && @arrUsefullTitles.include?(attrName))
        product[attrName] = elem if (attrName != 'another' )
      end
    end
    #puts product
    product.save!
  end

end