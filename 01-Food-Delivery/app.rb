require_relative 'app/repositories/meals_repository'
require_relative 'app/repositories/customers_repository'
require_relative 'app/repositories/employees_repository'
require_relative 'app/repositories/orders_repository'
require_relative 'router'

m_csv  = File.join(__dir__, 'data/meals.csv')
m_repo = MealsRepository.new(m_csv)
c_csv  = File.join(__dir__, 'data/customers.csv')
c_repo = CustomersRepository.new(c_csv)
e_csv  = File.join(__dir__, 'data/employees.csv')
e_repo = EmployeesRepository.new(e_csv)
o_csv  = File.join(__dir__, 'data/orders.csv')
o_repo = OrdersRepository.new(o_csv, m_repo, c_repo, e_repo)
router = Router.new(meals_repo: m_repo, customers_repo: c_repo, employees_repo: e_repo, orders_repo: o_repo)

# Start the app
router.run
