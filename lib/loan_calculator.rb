class LoanCalculator
    attr_accessor :loan_amount, :loan_term_in_months, :interest_rate_per_year, :repayment_frequency

    def initialize(loan_amount:, loan_term_in_months:, interest_rate_per_year:, repayment_frequency:)
        @loan_amount = loan_amount.to_f
        @loan_term_in_months = loan_term_in_months.to_i
        @interest_rate_per_year = interest_rate_per_year.to_f
        @repayment_frequency = repayment_frequency
    end


end


