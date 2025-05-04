Rails.application.config.session_store :cookie_store, key: '_vaanam_session',
  secure: Rails.env.production?,
  same_site: :lax # or :strict