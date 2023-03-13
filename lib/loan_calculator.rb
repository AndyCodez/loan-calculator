class LoanCalculator
    attr_accessor :principle, :loan_term_in_months, :interest_rate_per_year, :repayment_frequency

    def initialize(principle:, loan_term_in_months:, interest_rate_per_year:, repayment_frequency:)
        @principle = principle.to_f
        @loan_term_in_months = loan_term_in_months.to_i
        @interest_rate_per_year = interest_rate_per_year.to_f
        @repayment_frequency = repayment_frequency
    end

    def calculate_repayments

        validate_inputs

        case repayment_frequency
            when "bi-monthly"
                num_of_payments = @loan_term_in_months / 2
                periodic_interest = ((interest_rate_per_year/100.0) / 12.0) * 2.0
            when "monthly"
                num_of_payments = @loan_term_in_months
                periodic_interest = (interest_rate_per_year/100.0) / 12.0
            when "weekly"
                num_of_payments = @loan_term_in_months * 4
                periodic_interest = ((interest_rate_per_year/100.0) / 12.0) / 4
            end

            repayment_amount = @principle / num_of_payments

            repayments = [["principle", "interest_amount", "amount_paid", "balance"]]
            total_payments = 0
            total_interest_amount = 0
            balance = Float::INFINITY
            while num_of_payments >= 0 && balance > 0
                installments = []
                
                installments << @principle
                
        
                interest_amount = (@principle * periodic_interest)/100
        
                total_interest_amount += interest_amount

                installments << interest_amount
        
                if repayment_amount > (interest_amount + balance)
                    amount_paid = interest_amount + balance
                else
                    amount_paid = repayment_amount - interest_amount
                end

        
                installments << amount_paid
        
                @principle -= amount_paid
        
                total_payments += amount_paid
                
                balance = @principle
        
                installments << balance
                
                repayments << installments
        
                num_of_payments-1
            end
        
            print_table(repayments)
    end

    private
    
    def validate_inputs
        raise ArgumentError, "Loan amount should be a positive number" unless principle.positive?
        raise ArgumentError, "Loan term in months should be a positive integer" unless loan_term_in_months.positive? && loan_term_in_months.is_a?(Integer)
        raise ArgumentError, "Interest rate per year should be a positive number" unless interest_rate_per_year.positive?
        raise ArgumentError, "Repayment frequency should be one of 'monthly', 'bi-monthly', or 'weekly'" unless ["monthly", "bi-monthly", "weekly"].include?(repayment_frequency)
    end

    def print_table(repayments)
        repayments.each do |repayment|
            puts "#{repayment[0]} | #{repayment[1]} | #{repayment[2]} | #{repayment[3]}"
        end
    end
    
end


