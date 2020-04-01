FactoryBot.define do
  factory :station_event do
    file_download
    station

    control_area { 'A002' }
    unit { 'R051' }
    scp { '02-00-00' }

    event_at { Time.zone.strptime('03/22/2020 20:00:00', '%m/%d/%Y %H:%M:%S') }

    description { 'REGULAR' }
    entries { 7_411_940 }
    exits { 2_515_962 }
  end
end
