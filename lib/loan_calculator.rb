class LoanCalculator
  attr_accessor :principle, :loan_term_in_months, :interest_rate_per_year, :repayment_frequency,
                :total_payments, :repayments, :total_interest_amount

  def initialize(principle:, loan_term_in_months:, interest_rate_per_year:, repayment_frequency:)
    @principle = principle.to_f
    @loan_term_in_months = loan_term_in_months
    @interest_rate_per_year = interest_rate_per_year.to_f
    @repayment_frequency = repayment_frequency
    @repayments = []
    @total_payments = 0
    @total_interest_amount = 0
  end

  def calculate_repayments
    validate_inputs

    periodic_interest, repayment_amount = calc_payment_info
    balance = Float::INFINITY

    while balance.positive?
      installments = [@principle]
      interest_amount = (@principle * periodic_interest) / 100
      @total_interest_amount += interest_amount
      installments << interest_amount

      amount_paid = repayment_amount > (interest_amount + balance) ? (interest_amount + balance) : (repayment_amount - interest_amount)

      installments << amount_paid

      @principle -= amount_paid
      @total_payments += amount_paid + interest_amount
      balance = @principle <= 0 ? 0 : @principle
      installments << balance

      @repayments << installments
    end

    print_output
    @repayments
  end

  def print_output
    print_table(@repayments)
    puts "Total payments: #{@total_payments.round(2)}"
    puts "Total interest amount: #{@total_interest_amount.round(2)}"
  end

  private

  def calc_payment_info
    case repayment_frequency
    when 'bi-monthly'
      num_of_payments = @loan_term_in_months / 2
      periodic_interest = ((interest_rate_per_year / 100.0) / 12.0) * 2.0
    when 'monthly'
      num_of_payments = @loan_term_in_months
      periodic_interest = (interest_rate_per_year / 100.0) / 12.0
    when 'weekly'
      num_of_payments = @loan_term_in_months * 4
      periodic_interest = ((interest_rate_per_year / 100.0) / 12.0) / 4
    end

    repayment_amount = @principle / num_of_payments
    [periodic_interest, repayment_amount]
  end

  def validate_inputs
    raise ArgumentError, 'Loan amount should be a positive number' unless principle.positive?

    unless loan_term_in_months.positive? && loan_term_in_months.is_a?(Integer)
      raise ArgumentError,
            'Loan term in months should be a positive integer'
    end
    unless interest_rate_per_year.positive?
      raise ArgumentError,
            'Interest rate per year should be a positive number'
    end
    raise ArgumentError, "Repayment frequency should be one of 'monthly', 'bi-monthly', or 'weekly'" unless %w[
      monthly bi-monthly weekly
    ].include?(repayment_frequency)
  end

  def print_table(repayments)
    header = %w[Principle Interest Payment Balance]
    printf("%-15s%-15s%-15s%-15s\n", *header)
    repayments.each do |repayment|
      printf("%-14.2f%-14.2f%-14.2f%-14.2f\n", repayment[0], repayment[1], repayment[2], repayment[3])
    end
  end
end
