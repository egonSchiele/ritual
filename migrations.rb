require 'rubygems'
require 'mysql2'
require 'yaml'

CONFIG = Yaml.load("connection.yml").merge({'host': 'localhost', 'port': 3306})

con = Mysql2::Client.new(CONFIG)

con.query(%{
CREATE TABLE IF NOT EXISTS pages (
  id integer PRIMARY KEY AUTO_INCREMENT,
  url STRING,
  contents TEXT
  );
})
