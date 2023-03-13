require_relative './lib/loan_calculator'

puts "Welcome to the Loan Calculator!"

print "Enter the loan amount: "
principle = gets.chomp

print "Enter the loan term in months: "
loan_term_in_months = gets.chomp

print "Enter the interest rate per year: "
interest_rate_per_year = gets.chomp

print "Enter the repayment frequency (monthly, bi-monthly, or weekly): "
repayment_frequency = gets.chomp

calculator = LoanCalculator.new(
  principle: principle,
  loan_term_in_months: loan_term_in_months,
  interest_rate_per_year: interest_rate_per_year,
  repayment_frequency: repayment_frequency
)

calculator.calculate_repayments
