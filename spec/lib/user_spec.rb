require "user"

RSpec.describe User do
  describe "User initialization and setters" do
    it "shouldnt allow other than string for related country" do
      expect{
        User.new(1234)
      }.to raise_error(RuntimeError,"Error, related_country must be a String and a valid Country ISO code")
    end

    it "shouldnt allow related_country to be an invalid two chars ISO code" do
      expect{
        User.new("CHILE")
      }.to raise_error(RuntimeError,"Error, related_country must be a String and a valid Country ISO code")
    end

    it "should allow related_country to be an valid two chars ISO code as string" do
      expect{
        User.new("cl")
      }.not_to raise_error
    end
  end
end