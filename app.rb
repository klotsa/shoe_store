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
    erb(:store_form)
  end
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

# individual store
get('/stores/:id') do
  @store = Store.find(params.fetch('id').to_i())
  @brands = @store.brands()
 erb(:store)
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

#post a new brand to a certain store
post('/stores/:id/add_brand') do
  store = Store.find(params.fetch('id').to_i())
  name = params[:name]
  price = params[:price]
  if name != "" && price != ""
    store.brands.new({:name => name, :price => price})
    store.save()
  end
  @stores = Store.all()
  erb(:index)
end
