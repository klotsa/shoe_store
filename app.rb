require("bundler/setup")
Bundler.require(:default)
require("pry")

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

#show home page
get '/' do
  @stores = Store.all()
  erb(:index)
end

#STORE
#view all stores
get('/stores') do
  @stores = Store.all()
  erb(:stores)
end

#add a new store
get('/stores/add') do
  @brands = Brand.all()
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

#BRAND
