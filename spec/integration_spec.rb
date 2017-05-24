
require('spec_helper')

describe('add a store', {:type => :feature}) do
  it('allows a user to add new store') do
    visit('/')
    click_link('Edit List of Stores')
    fill_in('name', :with =>'big 5')
    click_button('Add to Stores')
    expect(page).to have_content('Big 5')
  end
end


describe('add a brand', {:type => :feature}) do
  it('allows a user to add new brand') do
    new_store = Store.create({:name => "Big 5"})
    new_brand = Brand.create({:name => "Adidas", :price => 40})
    visit("/stores/#{new_brand.id}")
    click_button('Save')
    expect(page).to have_content('Adidas')
  end
end

describe('view all brands', {:type => :feature}) do
  it('allows a user to view all brands') do
    first_brand = Brand.create({:name => 'Nike', :price => '99'})
    second_brand = Brand.create({:name => 'Puma', :price => '89'})
    visit('/brands')
    expect(page).to have_content(first_brand.name)
    expect(page).to have_content(second_brand.name)
  end
end


describe('List of stores', {:type => :feature}) do
  it('allows a user to see all of the stores') do
    first_store = Store.create({:name => 'Footware'})
    second_store = Store.create({:name => 'Modern Shoes'})
    visit('/')
    expect(page).to have_content(first_store.name)
    expect(page).to have_content(second_store.name)
  end
end
