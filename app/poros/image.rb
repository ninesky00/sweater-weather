class Image
  attr_reader :location, :description, :image_url, :author, :username
  def initialize(data)
    @location = data[:results].first[:tags].first[:title] || 'nil'
    @description = data[:results].first[:description] || data[:results].first[:alt_description]
    @image_url = data[:results].first[:urls][:regular] || 'nil'
    @author = data[:results].first[:user][:name] || 'nil'
    @username = data[:results].first[:user][:username] || 'nil'
  end
end