class Party < Sequel::Model
  many_to_one :host, key: :host_id, class: 'User'
  many_to_many :guests, class: 'User'
  one_to_many :track_requests

  def Party.generate_join_code
    SecureRandom.hex(3)
  end
end
