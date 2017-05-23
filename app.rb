require("bundler/setup")
Bundler.require(:default)
require("pry")

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

#show home page
get '/' do
  @stores = Store.all()
  erb(:index)
end

#STORES
#view all stores
get('/stores') do
  @stores = Store.all()
  erb(:stores)
end

#add a new store
get('/stores/add') do
  erb(:store_form)
end

#post a new store
post('/stores/new') do
  name = params.fetch('name')
  @new_store = Store.new({:name => name})
  if @new_store.save()
    redirect('/stores')
  else
    erb(:error)
  end
end

# individual store
get('/stores/:id') do
  # @store = Store.find(params.fetch('id').to_i())
  # @brands = @store.brands()
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  @brands = Brand.all()

 erb(:store)
end


#rename a store
patch('/stores/:id/edit') do
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  name = params.fetch('name')
  @store.update({:name => name})
  redirect('/stores/'.concat(store_id.to_s()))
end

#delete a store
delete("/stores/:id/delete") do
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  @store.delete()
  redirect('/')
end


#BRANDS
#view all brands
get('/brands') do
  @brands = Brand.all()
  erb(:brands)
end

#add a new brand
get('/brands/new') do
  erb(:brand_form)
end

#add a brand to store
patch('/stores/:id') do
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  brand_ids = params.fetch('brand_ids')
  brand_ids.each() do |brand_id|
    brand = Brand.find(brand_id)
    @store.brands.push(brand)
  end
  redirect('/stores/'.concat(store_id.to_s()))
end

# delete('/stores/view/:id/edit/delete') do
#   store_id = params.fetch('id').to_i()
#   @store = Store.find(store_id)
#   @store.delete()
#   redirect('/')
# end

post ('/brands') do
  name = params.fetch('name')
  price = params.fetch('price')
  @brands = Brand.new({:name => name, :price => price})
  if @brands.save()
  redirect(back)
  else
    erb(:error)
  end
end
#
# #post a new brand to a certain store
# post('/stores/:id/add_brand') do
#   store = Store.find(params.fetch('id').to_i())
#   name = params[:name]
#   price = params[:price]
#   if name != "" && price != ""
#     store.brands.new({:name => name, :price => price})
#     store.save()
#   else
#     erb(:error)
#   end
#   @stores = Store.all()
#   erb(:index)
# end
