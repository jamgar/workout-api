class JsonWebToken
  # HMAC_SECRET = Rails.application.secrets.secret_key_base
  #??? secret_key_base= no secrets.yml in 5.2
  HMAC_SECRET = '15e0cb8f5758656ff750129c'

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
