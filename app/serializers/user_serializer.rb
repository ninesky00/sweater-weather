class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :auth_token
end
