class Company
  attr_reader :name, :selected_countries 

  def initialize(name='', selected_countries=[])
    @name = name
    @selected_countries = selected_countries
  end

  def name=(name)
    if name.class.eql?(String) && name != ''
      @name = name
    else
      raise "Wrong data type for name or blank"
    end
  end

  def selected_countries=(selected_countries)
    if selected_countries.class.eql?(Array) && selected_countries != []
      @selected_countries = selected_countries
    else
      raise "Wrong data type for selected_countries or empty" 
    end
  end

  def self.filter_by_user(companies, current_user=nil)
    if current_user.nil?
      # Si no viene el current user, retorna el array completo de companies sin filtrar.
      return companies
    else
      sent_companies = companies
      filtered_companies = []
      companies.each do |company|
        if company.selected_countries.include?(current_user.related_country)
          filtered_companies << company
        end
      end
      return filtered_companies
    end  
  end
end