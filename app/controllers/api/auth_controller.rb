class Api::AuthController < ApplicationController
    # POST /api/auth/login
    def login
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        token = encode_token({ user_id: user.id })
        render json: { token: token, user: user.slice(:id, :name, :email) }
      else
        render json: { errors: ["Invalid email or password"] }, status: :unauthorized
      end
    end
  
    # Example of a protected endpoint
    def profile
      user = current_user
      if user
        render json: { user: user.slice(:id, :name, :email) }
      else
        render json: { errors: ["Not authorized"] }, status: :unauthorized
      end
    end
  
    private
  
    def encode_token(payload)
      JWT.encode(payload, Rails.application.secret_key_base)
    end
  
    def auth_header
      request.headers['Authorization']
    end
  
    def decoded_token
      if auth_header
        token = auth_header.split(' ')[1]
        begin
          JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end
    end
  
    def current_user
      if decoded_token
        user_id = decoded_token[0]['user_id']
        @current_user ||= User.find_by(id: user_id)
      end
    end
  end