class Reports
  class StationTotals < Reports
    attr_reader :station_id, :options

    def initialize(station_id, options = {})
      @station_id = fetch_station(station_id)
      @options = options
    end

    def execute
      records = ActiveRecord::Base.connection.execute(query)

      results = []

      records.each do |record|
        results << { week: record['formatted_week'], total: record['total'] }
      end

      results
    end

    private

    def query
      <<-SQL
    SELECT
    week,
    total,
    to_char(week, 'YYYY-MM-DD') as formatted_week
    FROM
    (
      SELECT
      date_trunc('week', event_at) AS week,
      sum(st.entries) as total
      FROM
      station_events s
      JOIN stations                USING (station_id)
      JOIN station_total_events st USING (station_event_id)
      JOIN station_divisions sd    USING (station_id)
      JOIN divisions d             USING (division_id)
      WHERE station_id = #{sanitize_value(station_id)}
      #{date_range_sql}
      AND d.division IN ('BMT', 'IND', 'IRT')
      GROUP BY 1
      ORDER BY 1
    )s
      SQL
    end

    def date_range_sql
      return @date_range_sql if defined? @date_range_sql

      @date_range_sql = ''

      begin_week = sanitize_value(options[:begin_week])
      end_week = sanitize_value(options[:end_week])

      date_trunc_sql = "date_trunc('week', event_at)"

      @date_range_sql = if begin_week && end_week
                          " AND #{date_trunc_sql} BETWEEN '#{begin_week}' AND '#{end_week}'"
                        elsif begin_week
                          " AND #{date_trunc_sql} > '#{begin_week}'"
                        elsif end_week
                          " AND #{date_trunc_sql} < '#{end_week}'"
                        end

      @date_range_sql
    end

    def fetch_station(station)
      case station
      when Station         then station.id
      when String, Integer then Station.find(station).id
      else raise ArgumentError, "reason: #{station.inspect} must be a Station or id"
      end
    end
  end
end
