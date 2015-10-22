class Oystercard

  attr_reader :balance, :journey

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey = Journey.new
    @in_use = false
  end

  def top_up amount
    raise "the limit is #{Oystercard::MAX_BALANCE}" if new_balance(amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    deduct Journey::PENALTY_FARE if @in_use
    fail StandardError, "Minimum balance is £#{MIN_BALANCE}" unless @balance >= MIN_BALANCE
    journey.enter(station)
    @in_use = true
  end

  def touch_out(station)
    journey.leave(station)
    deduct journey.fare
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def new_balance(amount)
    curent_value = balance + amount
  end

  def deduct amount
    @balance -= amount
  end


end
