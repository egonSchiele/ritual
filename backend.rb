require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'mysql2'
require 'yaml'

CONFIG = Yaml.load("connection.yml").merge({'host': 'localhost', 'port': 3306})

def extract(url)
  begin
    open(url).read
  rescue
    ""
  end
end

def add_to_database(url, contents)
  con = Mysql2::Client.new(CONFIG)
  escaped_contents = con.escape(contents)
  escaped_url     = con.escape(url)
  con.query("insert into pages (url, contents) VALUES (#{escaped_url}, #{escaped_contents})")
  con.close
end

get '/add/:url' do
  contents = extract(params[:url])
  add_to_database(contents)
end
