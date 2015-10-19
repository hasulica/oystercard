class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up amount
    raise "the limit is #{Oystercard::MAX_BALANCE}" if new_balance(amount) > MAX_BALANCE
    @balance += amount
  end

  private

  def new_balance(amount)
    curent_value = @balance + amount
  end

end
