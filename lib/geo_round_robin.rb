class GeoRoundRobin
  @@current_cycle = nil

  def self.companies_for_slots(companies)
    company_cycle =  @@current_cycle || companies.cycle
    
    current_companies = [ 
      company_cycle.next,
      company_cycle.next
    ]
    @@current_cycle = company_cycle
    return current_companies
  end
end