class User < Sequel::Model
  one_to_many :hosting, key: :host_id, class: "Party"
  many_to_many :parties
  one_to_many :track_requests

  def User.create_from_hash(h)
    user = User[h['uid']]

    if user.nil?
      user = User.new()
      user.id        = h['uid']
      user.provider  = h['provider']
      user.name      = h['info']['name']
      user.token     = h['info']['token']
      user.image_url = h['info']['image']
      user.raw       = YAML.dump(h)
      user.save
    end

    return user
  end

  def start_party(name, playlist_id)
    party = Party.new()
    party.host_id = self.id
    party.name = name
    party.playlist_id = playlist_id
    party.join_code = Party.generate_join_code
    party.save
    return party
  end

  def spotify?
    self.provider == 'spotify'
  end
end