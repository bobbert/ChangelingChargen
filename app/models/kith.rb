class Kith < ActiveRecord::Base
  has_many :characters
  has_many :secondary_characters, :class_name => "Character", :foreign_key => "second_kith_id"
  belongs_to :seeming

end
