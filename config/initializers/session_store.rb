# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_JMasterInterface_session',
  :secret      => '3f0f79909f3ebb4ebadbd1daf2c3ba2a65b45ad0e5f7ce591cdd5b6d2f87fd8bc009622c0d1e0fe84fb1196d76571ddf4d3f43ec85af475a19c3b207c080c1a8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
