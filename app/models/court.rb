class Court < ActiveRecord::Base
  has_many :characters

  # human-readable name of court
  def court_as_human_name
    return name if name == 'Courtless'
    name + ' Court'
  end
  
  # name of corresponding CSS class
  def css_style
    return 'courtless-style' if name == 'Courtless'
    return name.downcase + '-court-style'
  end
  
end
