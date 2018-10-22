class GeoRoundRobin
  #for further purposes
  @@current_cycle = nil

  def self.companies_for_slots(companies, slots=nil)
    # Podria validar que los datos dentro de companies sea de la clase correspondiente pero seria limitar la funcionalidad.
    raise "companies should be an Array of Companies" unless companies.class.eql?(Array) && companies.any? 
    raise "Slots has to be a number or nil" unless slots.class.eql?(Integer) || slots.nil?
    # returns 2 by default
    slots = slots || 2
    # current cycle or a new one based on how many companies there are
    company_cycle =  @@current_cycle || companies.cycle
    
    current_companies = []
    
    slots.times do  
      current_companies << company_cycle.next
    end
    @@current_cycle = company_cycle
    return current_companies
  end
end