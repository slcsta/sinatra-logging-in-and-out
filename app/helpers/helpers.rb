class Helpers
    def self.current_user(session_hash)
        #use user_id from the session hash to find teh user in the database and return that user
        User.find(session_hash[:user_id])
    end

    def self.is_logged_in?(session_hash)
        !!session_hash[:user_id]

    end
end