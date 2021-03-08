class ImageSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  attribute :image do |object|
    {location: object.location,
    image_url: object.image_url,
    description: object.description,
    credit: { 
      author: object.author,
      username: object.username,
    }}
  end
end
