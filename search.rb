require 'rubygems'
require 'mysql2'
require 'yaml'
require 'geocoder'

CONFIG = YAML.load(File.read("connection.yml")).merge({'host' => 'localhost', 'port' => 3306})

def distance(point1, point2)
  Math.sqrt((point1[0] - point2[0]) ** 2 + (point1[1] - point2[1]) ** 2)
end

def search url, contents, location
  coords = Geocoder.coordinates(location)
  raise "couldn't find location" unless coords
  con              = Mysql2::Client.new(CONFIG)
  escaped_url      = con.escape(url)
  escaped_contents = con.escape(contents)
  query            = %{
select * from pages
where url like '%#{escaped_url}%'
and contents like '%#{escaped_contents}%'
  }
  results = []
  con.query(query).each do |row|
    dist = distance([row['latitude'], row['longitude']], coords)
    if dist < 0.025
      p row
    end
  end
  con.close
end

if ARGV.empty?
  puts "Usage: #{$0} <url> <contents> <location>"
  exit
end

url      = ARGV[0]
contents = ARGV[1]
location = ARGV[2]

locations = {
  'home' => "400 Upper Terrace, San Francisco, CA 94117",
  'work' => "555 Bryant St, San Francisco, CA 94107"
}

location = locations[location] || location

search url, contents, location
