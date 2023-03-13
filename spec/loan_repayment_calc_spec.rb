require_relative '../lib/loan_calculator'

RSpec.describe LoanCalculator do
  describe '#initialize' do
    it 'sets instance variables correctly' do
      loan_calculator = LoanCalculator.new(
        principle: 10_000,
        loan_term_in_months: 24,
        interest_rate_per_year: 5.5,
        repayment_frequency: 'monthly'
      )

      expect(loan_calculator.principle).to eq(10_000.0)
      expect(loan_calculator.loan_term_in_months).to eq(24)
      expect(loan_calculator.interest_rate_per_year).to eq(5.5)
      expect(loan_calculator.repayment_frequency).to eq('monthly')
    end
  end

  context 'when validating inputs' do
    it 'raises an error if the principle is not positive' do
      calculator = LoanCalculator.new(principle: -100, loan_term_in_months: 240, interest_rate_per_year: 6.5,
                                      repayment_frequency: 'monthly')
      expect do
        calculator.calculate_repayments
      end.to raise_error(ArgumentError, 'Loan amount should be a positive number')
    end

    it 'raises an error if the loan term in months is not a positive integer' do
      calculator = LoanCalculator.new(principle: 100_000, loan_term_in_months: -240, interest_rate_per_year: 6.5,
                                      repayment_frequency: 'monthly')
      expect do
        calculator.calculate_repayments
      end.to raise_error(ArgumentError, 'Loan term in months should be a positive integer')
    end

    it 'raises an error if the interest rate per year is not positive' do
      calculator = LoanCalculator.new(principle: 100_000, loan_term_in_months: 240, interest_rate_per_year: -6.5,
                                      repayment_frequency: 'monthly')
      expect do
        calculator.calculate_repayments
      end.to raise_error(ArgumentError, 'Interest rate per year should be a positive number')
    end

    it 'raises an error if the repayment frequency is not valid' do
      calculator = LoanCalculator.new(principle: 100_000, loan_term_in_months: 240, interest_rate_per_year: 6.5,
                                      repayment_frequency: 'yearly')
      expect do
        calculator.calculate_repayments
      end.to raise_error(ArgumentError, "Repayment frequency should be one of 'monthly', 'bi-monthly', or 'weekly'")
    end

    it 'does not raise an error if all inputs are valid' do
      calculator = LoanCalculator.new(principle: 100_000, loan_term_in_months: 240, interest_rate_per_year: 6.5,
                                      repayment_frequency: 'monthly')
      expect { calculator.calculate_repayments }.not_to raise_error
    end
  end

  describe '#calculate_repayments' do
    it 'returns an array of repayments' do
      calculator = LoanCalculator.new(principle: 1000, loan_term_in_months: 240, interest_rate_per_year: 6.5,
                                      repayment_frequency: 'monthly')
      expect(calculator.calculate_repayments).to be_an_instance_of(Hash)
    end

    # context 'with valid inputs' do
    #   it 'calculates repayments correctly even for large principle' do
    #     calculator = LoanCalculator.new(principle: 10_000_000_000, loan_term_in_months: 24, interest_rate_per_year: 12.67,
    #                                     repayment_frequency: 'weekly')
    #     repayments = calculator.calculate_repayments
    #     expect(repayments.last[3]).to be_within(0.01).of(0.0)
    #   end
    # end
  end
end
