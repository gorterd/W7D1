class User < ApplicationRecord
    attr_reader :password

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: {message: 'Password cannot be blank'}
    validates :password, length: {minimum: 8}, allow_nil: true

    before_validation :ensure_session_token

    has_many :cats, foreign_key: :owner_id, dependent: :destroy

    def self.find_by_credentials(username, pw)
        return nil unless user_match = User.find_by(username: username)
        
        user_match.is_password?(pw) ? user_match : nil
    end

    def reset_session_token!
        self.session_token = generate_session_token
        
        if self.save
            self.session_token
        else
            self.errors[:session_token] << "Could not reset session!"
            nil
        end
    end
    
    def password=(new_pw)
        @password = new_pw
        self.password_digest = BCrypt::Password.create(new_pw)
    end
    
    def is_password?(pw)
        BCrypt::Password.new(self.password_digest)
            .is_password?(pw)
    end

    private

    def ensure_session_token
        self.session_token ||= generate_session_token
    end
    
    def generate_session_token
        loop do
            new_token = SecureRandom::urlsafe_base64(30)
            return new_token unless User.exists?(session_token: new_token)
        end
    end
    
end
