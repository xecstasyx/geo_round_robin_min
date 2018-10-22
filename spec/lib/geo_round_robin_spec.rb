require "company"
require "user"
require "geo_round_robin"

RSpec.describe GeoRoundRobin do
  describe "#companies_for_slots" do
    context "companies (first argument) validations" do
      it "should raise error if companies not present" do
        expect{
          GeoRoundRobin.companies_for_slots([])
        }.to raise_error(RuntimeError, "companies should be an Array of Companies")
      end

      it "should raise error if companies are not an array" do
        expect{
          GeoRoundRobin.companies_for_slots('')
        }.to raise_error(RuntimeError, "companies should be an Array of Companies")
      end
    end

    context "slots (second argument) validation if passed" do
      let!(:companies){ [
        Company.new("Empresa 1", ["cl", "pe", "ar"]),
        Company.new("Empresa 2", ["cl", "co", "br", "us"]),
        Company.new("Empresa 3", ["bo", "ar", "br", "uk"]),
        Company.new("Empresa 4", ["us", "ca", "cl"])
      ] }
      it "should raise error if slots is not an integer" do
        expect{
          GeoRoundRobin.companies_for_slots(companies, "dos slots")
        }.to raise_error(RuntimeError, "Slots has to be a number or nil")
      end

      it "should not raise error if slots is nil" do
        expect{
          GeoRoundRobin.companies_for_slots(companies, nil)
        }.not_to raise_error
      end
    end

    context "when i send filtered companies but i dont define slots" do
      let!(:companies){ [
        Company.new("Empresa 1", ["cl", "pe", "ar"]),
        Company.new("Empresa 2", ["cl", "co", "br", "us"]),
        Company.new("Empresa 3", ["bo", "ar", "br", "uk"]),
        Company.new("Empresa 4", ["us", "ca", "cl"])
      ] }
      let!(:user){ User.new('cl')}
      let(:filtered_companies) {
        Company.filter_by_user(companies, user)
      }
      let(:slots) { nil }

      it "should return default amount of companies defined to be 2 slots" do
        GeoRoundRobin.class_variable_set(:@@current_cycle, nil)
        results = GeoRoundRobin.companies_for_slots(filtered_companies, slots)
        expect(results.count).to eq(2)
        # 1 - 2
        expect(results[0]).to have_attributes(name: 'Empresa 1')
        expect(results[1]).to have_attributes(name: 'Empresa 2')
      end

      it "should return different values next time its called" do
        results = GeoRoundRobin.companies_for_slots(filtered_companies, slots)

        expect(results.count).to eq(2)
        # 4 - 1
        expect(results[0]).to have_attributes(name: 'Empresa 4')
        expect(results[1]).to have_attributes(name: 'Empresa 1')
      end

      it "should return different values next time its called" do
        results = GeoRoundRobin.companies_for_slots(filtered_companies, slots)

        expect(results.count).to eq(2)
        # 2 - 4
        expect(results[0]).to have_attributes(name: 'Empresa 2')
        expect(results[1]).to have_attributes(name: 'Empresa 4')
      end
    end

    context "when i send filtered companies but i do define slots" do
      let!(:companies){ [
        Company.new("Empresa 1", ["cl", "pe", "ar"]),
        Company.new("Empresa 2", ["cl", "co", "br", "us"]),
        Company.new("Empresa 3", ["bo", "ar", "br", "uk"]),
        Company.new("Empresa 4", ["us", "ca", "cl"])
      ] }
      let!(:user){ User.new('cl')}
      let(:filtered_companies) {
        Company.filter_by_user(companies, user)
      }
      let(:slots) { nil }

      it "should return the amount of companies defined passed by as slots" do
        # I reset the class variable so it starts on a fresh cycle
        GeoRoundRobin.class_variable_set(:@@current_cycle, nil)
        slots = 3
        results = GeoRoundRobin.companies_for_slots(filtered_companies, slots)

        expect(results.count).to eq(slots)
        expect(results[0]).to have_attributes(name: 'Empresa 1')
        expect(results[1]).to have_attributes(name: 'Empresa 2')
        expect(results[2]).to have_attributes(name: 'Empresa 4')
      end
    end
  end
end