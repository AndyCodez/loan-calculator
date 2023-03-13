require_relative '../lib/loan_calculator'

RSpec.describe LoanCalculator do
    describe "#initialize" do
      it "sets instance variables correctly" do
        loan_calculator = LoanCalculator.new(
          principle: 10000,
          loan_term_in_months: 24,
          interest_rate_per_year: 5.5,
          repayment_frequency: "monthly"
        )
        
        expect(loan_calculator.principle).to eq(10000.0)
        expect(loan_calculator.loan_term_in_months).to eq(24)
        expect(loan_calculator.interest_rate_per_year).to eq(5.5)
        expect(loan_calculator.repayment_frequency).to eq("monthly")
      end
    end
    
end  