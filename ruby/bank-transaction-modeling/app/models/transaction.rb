class Transaction < ApplicationRecord
  belongs_to :src_account, class_name: "Account", foreign_key: "src_account_id", optional: true
  belongs_to :dst_account, class_name: "Account", foreign_key: "dst_account_id", optional: true

  def transaction_type
    if src_account_id.nil?
      "Deposit"
    elsif dst_account_id.nil?
      "Withdrawal"
    else
      "Transfer"
    end
  end
end
