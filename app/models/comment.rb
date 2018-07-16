# Comment Model
# Relates to: Article Model
class Comment < ApplicationRecord
  belongs_to :article
end
