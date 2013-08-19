require 'rubygems'
require 'sinatra'
require 'mysql2'
require 'yaml'

CONFIG = YAML.load(File.read("connection.yml")).merge({'host' => 'localhost', 'port' => 3306})

def add_to_database(url, contents)
  con              = Mysql2::Client.new(CONFIG)
  escaped_contents = con.escape(contents)
  escaped_url      = con.escape(url)
  query            = "insert into pages (url, contents) VALUES ('#{escaped_url}', '#{escaped_contents}')"
  con.query query
  con.close
end

post '/add' do
  url      = params[:url]
  contents = params[:contents]
  add_to_database(url, contents)
  "#{url} added to db!"
end
