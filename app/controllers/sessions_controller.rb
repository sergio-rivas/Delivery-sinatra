class SessionsController
  attr_reader :e_repo
  attr_accessor :user

  def initialize(repo)
    @e_repo = repo
    @user = nil
  end

  def sign_in
    puts "username?"
    username = gets.chomp
    puts "password?"
    password = gets.chomp
    verify_session(username, password)
  end

  def verify_session(username, password)
    return session if @employees_repo.find_by_username(username).nil?
    employee = @employees_repo.find_by_username(username)
    unless employee.password == password
      puts "Wrong credentials! Try again, you fool!"
      return session
    end
    return employee
  end

end
