class RoundsImport
  include ActiveModel::Model
  require 'roo'

  HEADER_ROW = 4
  DATA_ROW_START = HEADER_ROW + 1

  attr_accessor :file

  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  # tells that this ojbect has no related table in our database
  def persisted?
    false
  end
  
  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_items
    lottos = LottoNumber.all
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(HEADER_ROW)
    
    (DATA_ROW_START..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      next if Round.find_by(round: row["round"]) # 업데이트는 하지않음
      
      round = Round.new(
        round: row["round"],
        draw: row["draw_date"]
      )
      round.picked_nums.build([
          { lotto_number: lottos.select { |e| e.num == row["num1"] }.first },
          { lotto_number: lottos.select { |e| e.num == row["num2"] }.first },
          { lotto_number: lottos.select { |e| e.num == row["num3"] }.first },
          { lotto_number: lottos.select { |e| e.num == row["num4"] }.first },
          { lotto_number: lottos.select { |e| e.num == row["num5"] }.first },
          { lotto_number: lottos.select { |e| e.num == row["num6"] }.first },
          { lotto_number: lottos.select { |e| e.num == row["bonus"]}.first, bonus: true}
        ])
      
      round
    end
  end

  def imported_items
    @imported_items ||= load_imported_items
  end

  def save
    imported_items.compact!
    
    if imported_items.map(&:valid?).all?
      imported_items.each(&:save!)
      true
    else
      imported_items.each_with_index do |item, index|
        item.errors.full_messages.each do |msg|
          errors.add :base, "Row #{index + DATA_ROW_START}: #{msg}"
        end
      end
      false
    end
  end
end