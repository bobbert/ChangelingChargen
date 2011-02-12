class Kith < ActiveRecord::Base
  has_and_belongs_to_many :characters
  belongs_to :seeming

end
