require 'byebug'
require "countries/global"
require "awesome_print"
require_relative "lib/user"
require_relative "lib/company"
require_relative "lib/geo_round_robin"

if __FILE__ == $0
  current_user = User.new('cl')

  companies = []
  companies << Company.new("Empresa 1", ["cl", "pe", "ar"])
  companies << Company.new("Empresa 2", ["cl", "co", "br", "us"])
  companies << Company.new("Empresa 3", ["bo", "ar", "br", "uk"])
  companies << Company.new("Empresa 4", ["us", "ca", "cl"])

  results = Company.filter_by_user(companies, current_user)
  
  ap "Resultados filtrados segun pais del user:"
  puts "#{results.ai}"

  ap "Resultados primera visita"
  puts "#{GeoRoundRobin.companies_for_slots(results).ai}"
  ap "Resultados segunda visita"
  puts "#{GeoRoundRobin.companies_for_slots(results).ai}"
  ap "Resultados tercera visita"
  puts "#{GeoRoundRobin.companies_for_slots(results).ai}"
  ap "Resultados cuarta visita"
  puts "#{GeoRoundRobin.companies_for_slots(results).ai}"
end