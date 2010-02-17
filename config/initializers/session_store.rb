# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_viaduct_session',
  :secret      => '7e3223a4b0e6bd9428c2c120208f1113f9b60eec9c3093edaa53749901c0d525b685cd27c16e70d9683629952a8c305322f2a41d65690c7bdc3735c9815448b4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
