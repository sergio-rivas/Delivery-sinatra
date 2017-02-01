class Employee
  attr_reader :username, :role, :password
  attr_accessor :id

  def initialize(attributes = {})
    @username = attributes[:username]
    @role = attributes[:role]
    @id = attributes[:id]
    @password = attributes[:password]
    @orders = attributes[:orders] || []
  end

  def manager?
    @role == 'manager'
  end

  def delivery_guy?
    @role == 'delivery_guy'
  end
end
