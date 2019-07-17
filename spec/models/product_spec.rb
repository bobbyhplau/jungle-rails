require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:all) do
    @category = Category.new({name: "Fake Chinese Stuff"})
  end
  describe 'Validations' do
    it "should make a product when all the fields are filled" do
      product = Product.create({name: "Electric Scooter", price: 95.43, quantity: 40, category: @category})
      expect(product).to be_valid
    end
    it "should not let you create a nameless product" do
      product = Product.create({name: nil, price: 100.00, quantity: 1, category: @category})
      expect(product).to_not be_valid
    end
    it "should not let you create a product without a price" do
      product = Product.create({name: "Not Rice but Plastic", price: nil, quantity: 100, category: @category})
      expect(product).to_not be_valid
    end
    it "should not let you create a product with no quantity" do
      product = Product.create({name: "Fake Yugioh Cards", price: 4.00, quantity: nil, category: @category})
      expect(product).to_not be_valid
    end
    it "should not let you create a product with no category" do
      product = Product.create({name: "A Real Da Vonci", price: 1000.00, quantity: 1, category: nil})
      expect(product).to_not be_valid
    end
  end
end