class Order
  attr_accessor :id, :meal, :customer, :employee

  def initialize(attributes = {})
    @customer = attributes[:customer]
    @meal = attributes[:meal]
    @id = attributes[:id]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
