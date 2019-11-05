#ask the user what is their loan amount
#ask what is the APR
#ask what is the loan duration
#need to calculate and return the monthly interest rate
#need to calculate and return the loan duration in months

def prompt(msg)
    puts ">>#{msg}"
end

def validate(loan)
    loan.to_i.to_s == loan || loan.to_f.to_s == loan
end

loan_amount = nil
apr = nil
loan_duration = nil

loop do
    prompt "What is the loan amount? (No need to put $ sign in front and please exclude commas)"
    loan_amount = gets.chomp
    if validate(loan_amount) && !loan_amount
        break
    end
    prompt "You must enter a valid loan amount!"
end

loop do
    prompt "What is your interest rate? Please enter in decimal form - e.g. 5% interest is 0.05."
    apr = gets.chomp
    if validate(apr) && !apr
        break
    end
    prompt "You must enter a valid interest rate!"
end

loop do
    prompt "What is the loan duration? (In years)"
    loan_duration = gets.chomp
    if validate(loan_duration) && !loan_duration
        break
    end
    prompt "You must enter a valid loan duration!"
end

loan_duration = loan_duration.to_i*12

m = loan_amount.to_i * (apr.to_f / (1 - (1 + apr.to_f)**(-loan_duration)))
m = m.round(2)

calculator_info = <<-MSG
    Loan amount: $#{loan_amount}
    APR: #{apr} 
    Loan duration (in months): #{loan_duration}
    Monthly payment: $#{m}
MSG

puts calculator_info
