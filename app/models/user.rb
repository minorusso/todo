class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    validates :name,  presence: true, length: { maximum: 30 }
    before_validation { email.downcase! }
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    has_secure_password
    validates :password, length: { minimum: 6 }
    before_update :must_exist_last_admin_updating
    before_destroy :must_exist_last_admin_destroying

    def must_exist_last_admin_updating
        if User.where(admin: true).count == 1 && self.admin == false
          throw :abort
        end
    end
    def must_exist_last_admin_destroying
        if User.where(admin: true).count <= 1 && self.admin == true
          throw :abort
        end
    end
end
