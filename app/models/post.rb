class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    validates :title, presence: true
    validates :body, presence: true,
                    length: { minimum: 10, message: "must be at least 10 characters long" }
end
