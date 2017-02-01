require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
Dir.glob('./app/controllers/*', &method(:require))
Dir.glob('./app/models/*', &method(:require))
Dir.glob('./app/repositories/*', &method(:require))

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

# ------------------------------------------------------------------------------
# --------------------------OBJECT SETUP----------------------------------------

m_csv  = File.join(__dir__, 'data/meals.csv')
m_repo = MealsRepository.new(m_csv)
m_controller = MealsController.new(m_repo)
c_csv  = File.join(__dir__, 'data/customers.csv')
c_repo = CustomersRepository.new(c_csv)
c_controller = CustomersController.new(c_repo)
e_csv  = File.join(__dir__, 'data/employees.csv')
e_repo = EmployeesRepository.new(e_csv)
o_csv  = File.join(__dir__, 'data/orders.csv')
o_repo = OrdersRepository.new(o_csv, m_repo, c_repo, e_repo)
o_controller = OrdersController.new(m_repo, e_repo, c_repo, o_repo)
s_controller = SessionsController.new(e_repo)
USER = nil
# ------------------------------------------------------------------------------
# ------------------------------VIEWS SETUP-------------------------------------



get '/' do
  if s_controller.user
    erb :index
  else
    erb :login
end

post '/auth/login' do
    @username = params[:username]
    @password = params[:password]
    @user = s_controller.verify_session(@username, @password)
    if !@user
      flash[:error] = "Whoops! We could not find that account"
      redirect '/'
    else
      s_controller.user = @user
      redirect '/'
    end
end





# ------------------------------------------------------------------------------


# get '/list' do
#   @cookbook = cookbook
#   erb :list
# end

# get '/create' do
#   @cookbook = cookbook
#   erb :create
# end

# post '/create/' do
#   @cookbook = cookbook
#   name = params[:name]
#   time = params[:time]
#   description = params[:description]

#   erb :create_post, :locals => {'name' => name, 'time' => time, 'description' => description}
# end


# get '/remove' do
#   @cookbook = cookbook
#   erb :remove
# end

# post '/remove/' do
#   recipe_index = params[:recipe_choice].to_i
#   recipes = cookbook.all
#   cookbook.remove_recipe(recipe_index)
#   "You have removed the recipe!"
#   erb :index
# end

# get '/mark-complete'do
#   @cookbook = cookbook
#   erb :mark_complete
# end

# post '/mark-complete/' do
#   recipe_index = params[:recipe_choice].to_i
#   recipes = cookbook.all
#   cookbook.recipe_cooked(recipe_index)
#   "You have tested this recipe!"
#   erb :index
# end


# get '/import' do
#   erb :import
# end

# post '/import/' do
#   @ingredient = params[:ingredient]
#   @browser = Browser.new
#   @html_docs = @browser.html_doc_set(@ingredient)

#   erb :import_b
# end

# post '/import3/' do
#   @ingredient = params[:ingredient]
#   @browser = Browser.new
#   @html_docs = @browser.html_doc_set(@ingredient)
#   @i = params[:recipe_choice].to_i
#   @cookbook = cookbook

#   "Congratulation! Recipe Imported!"
#   erb :import_c
# end

# get '/team/:username' do
#   puts params[:username]
#   "The username is #{params[:username]}"
# end











