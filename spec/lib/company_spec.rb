require "company"
require "user"

RSpec.describe Company do
  describe "Company initialization and setters" do
    it "shouldnt allow other than string for name" do
      expect{
        Company.new(12312312, ["cl"])
      }.to raise_error(RuntimeError,"Wrong data type for name or blank")
    end

    it "shouldnt allow name to be an empty string" do
      expect{
        Company.new("", ["cl"])
      }.to raise_error(RuntimeError,"Wrong data type for name or blank")
    end

    it "should allow name to be a string not empty" do
      expect{
        Company.new("Empresa 2", ["cl"])
      }.not_to raise_error
    end

    it "shouldnt allow other than array for selected_countries" do
      expect{
        Company.new("Empresa 1", "cl")
      }.to raise_error(RuntimeError,"Wrong data type for selected_countries or empty")
    end

    it "shouldnt allow selected_countries to be an empty array" do
      expect{
        Company.new("Empresa 1", [])
      }.to raise_error(RuntimeError,"Wrong data type for selected_countries or empty")
    end

    it "should allow selected_countries to be an valid array not empty" do
      expect{
        Company.new("Empresa 2", ["cl", "br"])
      }.not_to raise_error
    end
  end

  describe "#filter_by_user" do
    context "when i send companies but no user" do
      let(:companies){ [
        Company.new("Empresa 1", ["cl", "pe", "ar"]),
        Company.new("Empresa 2", ["cl", "co", "br", "us"]),
        Company.new("Empresa 3", ["bo", "ar", "br", "uk"]),
        Company.new("Empresa 4", ["us", "ca", "cl"])
      ] }

      it "should return all the companies ive passed, unfiltered" do
        expect(Company.filter_by_user(companies)).to eq(companies)
      end
    end

    context "when i send companies and user related_country matches with any company" do
      let!(:companies){ [
        Company.new("Empresa 1", ["cl", "pe", "ar"]),
        Company.new("Empresa 2", ["cl", "co", "br", "us"]),
        Company.new("Empresa 3", ["bo", "ar", "br", "uk"]),
        Company.new("Empresa 4", ["us", "ca", "cl"])
      ] }
      let!(:user){ User.new('cl')}
      let(:expected_companies) {
        companies.find_all{|c| c.selected_countries.include?(user.related_country)}
      }
      let(:unexpected_companies){
        companies.find_all{|c| !c.selected_countries.include?(user.related_country)}
      }
      it "should return filtered companies based on user related country" do
        expect(Company.filter_by_user(companies, user)).to match(expected_companies)
        expect(Company.filter_by_user(companies, user)).to_not include(unexpected_companies)
      end
    end

    context "when i send companies and user related_country doesnt match with any company" do
      let!(:companies){ [
        Company.new("Empresa 1", ["cl", "pe", "ar"]),
        Company.new("Empresa 2", ["cl", "co", "br", "us"]),
        Company.new("Empresa 3", ["bo", "ar", "br", "uk"]),
        Company.new("Empresa 4", ["us", "ca", "cl"])
      ] }
      let!(:user){ User.new('jp')}
      
      it "should return filtered companies based on user related country" do
        expect(Company.filter_by_user(companies, user)).to eq([])
        expect(Company.filter_by_user(companies, user)).to_not include(companies)
      end
    end
  end
end