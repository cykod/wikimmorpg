# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Rooms_session',
  :secret      => '0d81436ffb717640939686b8937f444c4e69023210184c36acff9babd135e7d4038a277b75e7a8bddb5c6d24253ec7df2f9da322fe3890db0ab56188bf232cec'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
