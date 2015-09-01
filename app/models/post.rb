class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent:  :destroy

    #scope :all_posts, lambda { |value| where('id = (?)', value) if value }
end
