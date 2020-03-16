require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def test_accept_money
    register = CashRegister.new(1000)
    transaction = Transaction.new(20)
    transaction.amount_paid = 20

    previous_amount = register.total_money
    register.accept_money(transaction)
    current_amount = register.total_money

    assert_equal previous_amount + 20, current_amount
  end

  def test_change
    register = CashRegister.new(1000)
    transaction = Transaction.new(45)
    transaction.amount_paid = 60

    change = transaction.amount_paid - transaction.item_cost
    assert_equal register.change(transaction), change
  end

  def test_give_receipt
    register = CashRegister.new(1000)
    transaction = Transaction.new(30)

    assert_output("You've paid $#{transaction.item_cost}.\n") do
      register.give_receipt(transaction)
    end
  end

  def test_prompt_for_payment
    transaction = Transaction.new(30)
    input = StringIO.new('30')
    output = StringIO.new
    transaction.prompt_for_payment(input: input, output: output)
    assert_equal 30, transaction.amount_paid
  end


end

