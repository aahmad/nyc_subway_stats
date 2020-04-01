class GenerateTotals
  def initialize; end

  def execute
    ActiveRecord::Base.connection.execute('TRUNCATE station_total_events')
    ActiveRecord::Base.connection.execute(insert_totals_query)
  end

  private

  def insert_totals_query
    <<-SQL
      WITH totals AS (
       SELECT
       station_event_id,
       entries - lag(entries, 1) OVER w AS net_entries,
       exits - lag(exits, 1) OVER w AS net_exits
       FROM station_events
       WINDOW w AS (PARTITION BY control_area, unit, scp  ORDER BY event_at)
      )

      INSERT INTO station_total_events (station_event_id, entries, exits,
                                        created_at, updated_at)
      (
        SELECT
        t.station_event_id,
        CASE WHEN abs(t.net_entries) < 10000 THEN abs(t.net_entries) END,
        CASE WHEN abs(t.net_exits) < 10000 THEN abs(t.net_exits) END,
        NOW(),
        NOW()
        FROM
        station_events s, totals t
        WHERE t.station_event_id = s.station_event_id
      );
    SQL
  end
end
