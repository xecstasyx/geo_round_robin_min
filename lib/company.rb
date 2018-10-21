class Company
  attr_reader :name, :selected_countries 

  def initialize(name, selected_countries)
    @name = name
    @selected_countries = selected_countries
    validate
  end

  def name=(name)
    @name = name

    validate
  end

  def selected_countries=(selected_countries)
    @selected_countries = selected_countries

    validate
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

  private
    def validate
      raise "Wrong data type for name or blank" unless @name.class.eql?(String) && @name != ''
      raise "Wrong data type for selected_countries or empty" unless @selected_countries.class.eql?(Array) && @selected_countries != []
    end
end