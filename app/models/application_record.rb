# Single point of entry for customizations to ActiveRecord::Base
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
