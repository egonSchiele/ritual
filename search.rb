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
    # puts "dist: #{dist.inspect}"
    # TODO: would be nice to be able to specify how wide a radius to search in
    # (same location, same city, same state, etc)
    if dist < 0.025
      p row
    end
  end
  con.close
end

url      = ARGV[0]
contents = ARGV[1]
location = ARGV[2]
search url, contents, location
