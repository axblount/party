require 'sqlite3'
require 'sequel'
require 'yaml'
require 'securerandom'

Sequel::Model.plugin :timestamps

DB = Sequel.sqlite # 'dev.sqlite3.db'

DB.create_table :users do
  String :id, primary_key: true
  String :provider
  String :name
  String :token
  String :image_url
  String :raw, text: true
end

DB.create_table :parties do
  primary_key :id
  foreign_key :host_id, :users
  String :name
  Fixnum :delay_min, default: 2
  String :playlist_id
  String :join_code, unique: true, null: true
  TrueClass :expired, default: false
end

DB.create_table :parties_users do
  primary_key [:user_id, :party_id]
  foreign_key :user_id, :users
  foreign_key :party_id, :parties
end

DB.create_table :track_requests do
  primary_key [:user_id, :party_id, :track_id]
  foreign_key :user_id, :users
  foreign_key :party_id, :parties
  String :track_id
end

require_relative 'user'
require_relative 'party'
require_relative 'track_request'
