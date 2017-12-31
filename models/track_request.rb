class TrackRequests < Sequel::Model
  many_to_one :users
  many_to_one :parties
end