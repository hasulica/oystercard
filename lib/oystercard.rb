class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @in_journey = false
    @balance = balance
  end

  def top_up amount
    raise "the limit is #{Oystercard::MAX_BALANCE}" if new_balance(amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in
    fail StandardError, "Minimum balance is £#{MIN_BALANCE}" unless @balance >= MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct MIN_FARE
  end

  def in_journey?
    @in_journey
  end

  private

  def new_balance(amount)
    curent_value = balance + amount
  end

  def deduct amount
    @balance -= amount
  end

end
