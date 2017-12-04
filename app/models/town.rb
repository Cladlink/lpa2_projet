class Town < ActiveRecord::Base
  before_validation :load_position
  validates :latitude, :longitude, presence: true
  
  private
  def load_position
    places = Nominatim.search(name).limit(1).first
    if places
      self.latitude = places.lat
      self.longitude = places.lon
    end
  end
end