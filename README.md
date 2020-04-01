# NYC Subway Stats

The MTA are kind enough to [share statistics](http://web.mta.info/developers/turnstile.html) on the number of entries, and exits, at all stations and turnstiles. during certain time intervals. They CSV key to this file can be read [here](http://web.mta.info/developers/resources/nyct/turnstile/ts_Field_Description.txt). 

Thank you to the MTA for sharing this data. 

An example of the data that can be produced via this application:

![Screen Shot 2020-04-01 at 12 10 22 PM](https://user-images.githubusercontent.com/485873/78160342-52d3fc80-7433-11ea-8549-160eed50271f.png)

![Screen Shot 2020-03-30 at 3 04 00 PM](https://user-images.githubusercontent.com/485873/78089873-1dd69400-73b8-11ea-9d29-419f2c3454d9.png)

## The Application

This Ruby on Rails 6 project will download the relevant files, and import them into the database. 

### Requirements

This was created with Ruby 2.6.5, and Rails 6.0.2.2. The database is any version of PostgreSQL 9.5+. 

### Database Setup

Simply run `./bin/setup`, or `bundle exec rake db:setup` to initialize the database and create the migrations.

### Usage

One can download all the files from the MTA site, and then process each one individually via this rake task:

```
bundle exec rake populate:data
```

After all the data has been downloaded and populated into the database, some calculations on the cumulative entries and exits will have to be done:

```
bundle exec rake populate:totals
```

This will delete data in `station_total_events` for re-population.

### Workflow

The `FetchFileListings` class fetches the relevant files it sees from the MTA listing, and creates a record for each of the files in `FileDownload`. 

The `FetchAndParse` class then iterates over the unprocessed `FileDownload` objects, retrieving each one from the site, and then then parsing it using the `CSV` library.


### Models

`StationEvent` represents each entry from the downloaded file. This is linked to its source, `FileDownload`, the `Station`, and `Division`. 

### Bulk Data Load

The files are loaded in through Rail 6's built-in `insert_all` method. 

### Tests

There are ample tests on the models, and service objects, using `rspec`. 

### Linting

`rubocop` is bundled to provide linting.

## The Data

As an example, the raw data for the entries and exits for *59 St* station, *02-00-00*, looks like this:


| Date Time             | Entries  | Exits     | 
|-----------------------|----------|-----------|
| 03/21/2020 12:00:00   | 7411969  | 2516000   |
| 03/21/2020 16:00:00   | 7412028  | 2516024   | 
| 03/21/2020 20:00:00   | 7412053  | 2516040   |  
| 03/21/2020 12:00:00   | 7411969  | 2516000   |
| 03/21/2020 16:00:00   | 7412028  | 2516024   |                                       
| 03/21/2020 20:00:00   | 7412053  | 2516040   |                                          
| 03/22/2020 00:00:00   | 7412067  | 2516049   |                                         
| 03/22/2020 04:00:00   | 7412068  | 2516049   |                                    
| 03/22/2020 08:00:00   | 7412071  | 2516059   |                                         
| 03/22/2020 12:00:00   | 7412086  | 2516073   |    

It should be noted that `Entries` and `Exits` are both cumulative.

One challenge was to break up the cumulative figure for each turnstile, for a running total. This was to carry out weekly total operations.

These running totals are calculated in the `GenerateTotals` class.  

## Reports

Still being worked on but here is a way to return data for the totals for each week from `2019-12-01` to `2020-04-01` for the `59 ST` station. 


```
> report_options = { begin_week: '2019-12-01', end_week: '2020-04-01' }
> Reports::StationTotals.new('59 ST', options).execute

[
  {:week=>"2019-12-02", :total=>"57568"},
  {:week=>"2019-12-09", :total=>"56993"},
  {:week=>"2019-12-16", :total=>"54758"},
  {:week=>"2019-12-23", :total=>"45795"},
  {:week=>"2019-12-30", :total=>"46626"},
  {:week=>"2020-01-06", :total=>"56258"},
  {:week=>"2020-01-13", :total=>"55167"},
  {:week=>"2020-01-20", :total=>"49727"},
  {:week=>"2020-01-27", :total=>"55101"},
  {:week=>"2020-02-03", :total=>"55789"},
  {:week=>"2020-02-10", :total=>"55658"},
  {:week=>"2020-02-17", :total=>"48882"},
  {:week=>"2020-02-24", :total=>"56477"},
  {:week=>"2020-03-02", :total=>"54014"},
  {:week=>"2020-03-09", :total=>"44048"},
  {:week=>"2020-03-16", :total=>"19694"},
  {:week=>"2020-03-23", :total=>"6743"}
]
```
