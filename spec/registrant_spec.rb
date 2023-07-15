require './lib/registrant'

describe Registrant do
  describe "i1.setup" do
    it "t1 can create instantiate registrants " do
      #permit defaults as false
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 15 )

      expect(registrant_1).to be_a(Registrant)
    end

    it "t2 can recieve name, age, and permit attributes" do
      #permit defaults as false
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 15 )

      expect(registrant_1.name).to eq("Bruce")
      expect(registrant_1.age).to eq(18)
      expect(registrant_1.permit?).to be(true)
      expect(registrant_1.licensed_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

    it "t3 if permit argument is not provided it defaults to false" do
      #permit defaults as false
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 15 )

      expect(registrant_2.permit?).to be(false)
    end

    it "t4 can earn a permit" do
      #permit defaults as false
      registrant_1 = Registrant.new('Bruce', 18, true )
      registrant_2 = Registrant.new('Penny', 15 )

      expect(registrant_2.permit?).to be(false)

      registrant_2.earn_permit

      expect(registrant_2.permit?).to be(true)
    end
  end
end