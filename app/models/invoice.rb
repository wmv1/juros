class Invoice < ApplicationRecord
  belongs_to :subscription

  scope :pending, -> { where(paid: false) }
  scope :paid, -> { where(paid: true) }



  def pay
    if has_unpaid_previous_invoices?
      errors.add(:base, "Não é possível pagar esta fatura enquanto há faturas anteriores não pagas.")
      return false
    end
  
    update(paid: true)
  end
  
  private
  
  def has_unpaid_previous_invoices?
    # Se for a primeira fatura da assinatura, não há anteriores para verificar
    return false if first_invoice?
  
    # Verifica se existem faturas anteriores não pagas
    subscription.invoices
                .where("due_date < ? AND paid = ?", due_date, false)
                .exists?
  end
  
  def first_invoice?
    subscription.invoices.order(:due_date).first == self
  end
  
end
