class User
  attr_reader :related_country 

  def initialize(related_country)
    @related_country = related_country
    validate
  end

  def related_country=(related_country)
    @related_country = related_country
    validate
  end

  private
    def validate
      unless @related_country.class.eql?(String) && ::Country["#{@related_country}"]
        raise "Error, related_country must be a String and a valid Country ISO code"   
      end
    end
end