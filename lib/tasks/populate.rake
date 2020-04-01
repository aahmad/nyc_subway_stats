namespace :populate do
  desc 'Populate the database with the downloaded files'
  task data: :environment do
    # Download any files which have not from the website
    FetchFileListings.new.execute

    # Parse each of the downloaded files and save
    FetchAndParseData.new.execute
  end

  desc 'Populate the weekly totals for each station event'
  task totals: :environment do
    GenerateTotals.new.execute
  end
end
