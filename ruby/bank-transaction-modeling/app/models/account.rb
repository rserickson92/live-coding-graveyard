class Account < ApplicationRecord
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :account_type, inclusion: { in: %w[Checking Savings] }

  def transactions
    Transaction
      .where("src_account_id = ? OR dst_account_id = ?", id, id)
      .order(created_at: :desc)
  end

  def deposit(amount)
    with_lock do
      Transaction.create!(src_account: nil, dst_account: self, amount: amount)
      update!(balance: balance + amount)
    end
  end

  def withdraw(amount)
    with_lock do
      Transaction.create!(src_account: self, dst_account: nil, amount: amount)
      update!(balance: balance - amount)
    end
  end

  def transfer(amount, dst_account)
    Account.transaction do
      lock!
      dst_account.lock!

      Transaction.create!(src_account: self, dst_account: dst_account, amount: amount)
      update!(balance: balance - amount)
      dst_account.update!(balance: dst_account.balance + amount)
    end
  end
end
