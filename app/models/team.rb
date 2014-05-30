# encoding: UTF-8
class Team < ActiveRecord::Base
  attr_accessible :name, :group, :placeholder
  
  has_many :matches

  def flag_url size
    code = {"Brazil"=>"BR", "Croatia"=>"HR", "Mexico"=>"MX", "Cameroon"=>"CM", 
            'Spain'=>'ES', 'Netherlands'=>'NL', 'Chile'=>'CL', 'Australia'=>'AU',
            'Colombia'=>'CO', 'Greece'=>'GR', "Côte d'Ivoire"=>'CI', 'Japan'=>'JP',
            'Uruguay'=>'UY', 'Costa Rica'=>'CR', 'England'=>'ENG', 'Italy'=>'IT',
            'Switzerland'=>'CH', 'Ecuador'=>'EC', 'France'=>'FR', 'Honduras'=>'HN',
            'Argentina'=>'AR', 'Bosnia and Herzegovina'=>'BA', 'Iran'=>'IR', 'Nigeria'=>'NG',
            'Germany'=>'DE', 'Portugal'=>'PT', 'Ghana'=>'GH', 'United States'=>'US',
            'Belgium'=>'BE', 'Algeria'=>'DZ', 'Russia'=>'RU', 'South Korea'=>'KR'}[name]
    "flags/#{size}/#{code}.png"
  end
  
end
