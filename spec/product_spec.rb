require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "verifies everything is provided" do
      new_category = Category.create(name: 'Evergreens') 
      new_category.products.create({
        name:  'Giant Tea',
        description: "The Giant Tea is an uncommon, medium-sized plant and can be found only in some tundras. It blooms twice a year, f0r 3 weeks.",
        image: 'plante_1.jpg',
        quantity: 0,
        price: 64.99
        })        
    end

    it "provides an error that the name is not present" do
      new_category = Category.create(name: 'Evergreens') 
      new_category.products.create({
        description: "The Giant Tea is an uncommon, medium-sized plant and can be found only in some tundras. It blooms twice a year, f0r 3 weeks.",
        image: 'plante_1.jpg',
        quantity: 0,
        price: 64.99
        })
        expect(new_category.products[0]).to_not be_valid
        expect(new_category.products[0].errors.full_messages).to eq ["Name can't be blank"]
    end
    it "provides an error that the price is not present" do
      new_category = Category.create(name: 'Evergreens') 
      new_category.products.create({
        name:  'Giant Tea',
        description: "The Giant Tea is an uncommon, medium-sized plant and can be found only in some tundras. It blooms twice a year, f0r 3 weeks.",
        image: 'plante_1.jpg',
        quantity: 0
        })
        expect(new_category.products[0]).to_not be_valid
        expect(new_category.products[0].errors.full_messages).to include "Price can't be blank"
    end
    it "provides an error that the category is not present" do
      new_product = Product.create({
        name:  'Giant Tea',
        description: "The Giant Tea is an uncommon, medium-sized plant and can be found only in some tundras. It blooms twice a year, f0r 3 weeks.",
        image: 'plante_1.jpg',
        quantity: 0,
        price: 64.99
        })
        expect(new_product).to_not be_valid
        expect(new_product.errors.full_messages).to include "Category can't be blank"
    end
    it "provides an error that the quantity is not present" do
      new_category = Category.create(name: 'Evergreens') 
      new_category.products.create({
        name:  'Giant Tea',
        description: "The Giant Tea is an uncommon, medium-sized plant and can be found only in some tundras. It blooms twice a year, f0r 3 weeks.",
        image: 'plante_1.jpg',
        price: 64.99
        })
        expect(new_category.products[0]).to_not be_valid
        expect(new_category.products[0].errors.full_messages).to eq ["Quantity can't be blank"]
    end
  end
end