if Rails.env.production?
    Rails.application.config.session_store :cookie_store, key: '_forum2_session', same_site: :none, secure: true
  else
    Rails.application.config.session_store :cookie_store, key: '_forum2_session',same_site: :none
  end
  