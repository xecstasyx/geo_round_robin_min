class User
  attr_reader :related_country 

  def initialize(related_country='')
    @related_country = related_country
  end

  def related_country=(related_country)
    if related_country.class.eql?(String) && Country["#{related_country}"]
      @related_country = related_country
    else
      raise "Error, related_country must be a String and a valid Country ISO code"   
    end
  end
end