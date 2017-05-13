require("bundler/setup")
Bundler.require(:default)
require("pry")

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

#show home page
get '/' do
  @stores = Store.all()
  erb(:index)
end

#view all stores
get('/stores') do
  @stores = Store.all()
  erb(:stores)
end

#add a new store
get('/stores/add') do
  @brands = Brand.all()
  erb(:add_store)
end

# individual store
get('/stores/:id') do
  @store = Store.find(params.fetch('id').to_i())
  @brands = @store.brands()
 erb(:store)
end
