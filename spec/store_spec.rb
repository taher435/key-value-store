require "rails_helper"

describe Store do
  before :each do
    @store = Store.new
    @store.remove("addTestKey")
    @store.remove("getTestKey")

  end

  describe "#new" do
    it "creates a new instance of Store" do
      expect(@store).to be_an_instance_of Store
    end
  end

  describe "#add" do
    it "takes key and value and creates a key entry in Redis" do
      result = @store.add("addTestKey", "addTestValue1")
      expect(result.length).to eq(1)

      result = @store.add("addTestKey", "addTestValue2")
      expect(result.length).to eq(2)
    end
  end

  describe "#get" do
    it "takes a key along with timestamp and gives back the latest value object" do

      o1 = @store.add("getTestKey", "testValue-1")
      sleep(1/100) #fake delay to make sure both keys are added at different time
      o2 = @store.add("getTestKey", "testValue-2")

      key_value = @store.get("getTestKey")
      expect(key_value["value"]).to eq("testValue-2")

      key_value = @store.get("getTestKey", o1[0][:ts])
      expect(key_value["value"]).to eq("testValue-1")
    end
  end

  describe "#remove" do
    it "removes the given key from redis db" do
      @store.add("removeTestKey", "removeTestValue")
      @store.remove("removeTestKey")
      key_value = @store.get("removeTestKey")

      expect(key_value).to eq(nil)
    end
  end
end