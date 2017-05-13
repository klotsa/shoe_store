require('spec_helper')

describe(Store) do

  describe("#brands") do
    it("tells which brands are in this store") do
      test_store = Store.create({:name => "Amazon"})
      test_brand = test_store.brands.create({:name => "Nike", :price => 99.95})
      expect(test_store.brands()).to(eq([test_brand]))
    end
  end

  describe("#stores") do
    it(" will perform capitalizaton ") do
      test_store = Store.create({:name => "big foot"})
      expect(test_store.name()).to(eq("Big foot"))
    end
  end
end
