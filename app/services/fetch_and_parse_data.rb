class FetchAndParseData
  # @todo - re-process
  attr_reader :force_redownload, :verbose

  def initialize(verbose: true)
    @force_redownload = false
    @verbose = verbose
  end

  def execute
    FileDownload.where(processed_at: nil).each do |file_download|
      file_download.download_and_save!

      parse!(file_download)

      file_download.update(processed_at: Time.now)

      puts "Parsed #{file_download.url}...." if verbose
    end
  end

  private

  def parse_entry_exit(value)
    return unless value.present?

    Integer(value.strip, 10)
  end

  def parse!(file_download)
    rows = CSV.open(file_download.local_file, headers: true,
                                              header_converters: :symbol)

    records = []
    station_divisions = {}
    divisions = {}
    station_lines = {}
    lines = {}

    rows.each do |row|
      station = Station[row[:station]]

      divisions[row[:division]] ||= 1
      station_divisions[station.id] ||= {}
      station_divisions[station.id][row[:division]] = 1

      lines[row[:linename]] ||= 1
      station_lines[station.id] ||= {}
      station_lines[station.id][row[:linename]] = 1

      records << parse_row(file_download, station, row)
    end

    saved_divisions = save_divisions(divisions)
    save_station_divisions(saved_divisions, station_divisions)

    saved_lines = save_lines(lines)
    save_station_lines(saved_lines, station_lines)

    StationEvent.insert_all(records)
  end

  def parse_row(file_download, station, row)
    event_at_string = "#{row[:date]} #{row[:time]}"
    parsed_event_at = Time.zone.strptime(event_at_string, '%m/%d/%Y %H:%M:%S')

    {
      file_download_id: file_download.id,
      control_area: row[:ca],
      unit: row[:unit],
      scp: row[:scp],
      station_id: station.id,
      event_at: parsed_event_at,
      description: row[:desc],
      entries: parse_entry_exit(row[:entries]),
      exits: parse_entry_exit(row[:exits]),
      created_at: Time.zone.now,
      updated_at: Time.zone.now
    }
  end

  def save_lines(lines)
    saved_lines = {}

    lines.keys.each do |all_lines|
      all_lines.split(//).each do |individual_line|
        saved_lines[individual_line] = Line.find_or_create_by(line: individual_line)
      end
    end

    saved_lines
  end

  # Lines come in as a string, ie. "NQR456W".
  # They must be split to be treated individually.
  def save_station_lines(saved_lines, station_lines)
    station_lines.each do |station_id, all_lines|
      all_lines.keys.each do |lines|
        lines.split(//).each do |individual_line|
          StationLine.find_or_create_by(station_id: station_id,
                                        line: saved_lines[individual_line])
        end
      end
    end
  end

  def save_divisions(divisions)
    saved_divisions = {}

    divisions.keys.each do |division|
      saved_divisions[division] = Division.find_or_create_by(division: division)
    end

    saved_divisions
  end

  def save_station_divisions(saved_divisions, station_divisions)
    station_divisions.each do |station_id, divisions|
      divisions.keys.each do |division|
        StationDivision.find_or_create_by(station_id: station_id,
                                          division: saved_divisions[division])
      end
    end
  end
end
