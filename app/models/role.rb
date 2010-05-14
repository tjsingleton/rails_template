class Role < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :title

end