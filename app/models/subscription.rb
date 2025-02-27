
  class Subscription < ApplicationRecord
    belongs_to :contract
    has_many :invoices, dependent: :destroy
  
    enum :status, pending: 0, paid: 1, overdue: 2, canceled: 3
  
    # Método para calcular a quantidade de meses entre start_date e end_date do contrato
    def months_between
      start_date = contract.start_date
      end_date = contract.end_date
      
      return 0 if start_date.nil? || end_date.nil?
  
      # Verifica se a data de início é maior que a de fim
      if start_date > end_date
        raise ArgumentError, "A data de início do contrato não pode ser maior que a data de fim."
      end
      
      # Calcula a diferença de meses entre as duas datas do contrato
      months_diff = (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
      
      months_diff
    end
  
    # Método para gerar as faturas dentro de um intervalo de meses, com base nas datas do contrato
    def generate_invoices
      start_date = contract.start_date
      end_date = contract.end_date
  
      # Calcular a diferença em meses entre as datas do contrato
      months = months_between
  
      # Gerar uma fatura para cada mês no intervalo
      invoices = []
      (0..months).each do |i|
        invoice_date = start_date >> i  # Usa o operador "<<" para adicionar meses
        invoices << self.invoices.create!(
          paid: false,
          subscription_id: self.id, # Associa a fatura à assinatura
          due_date: invoice_date.end_of_month, # Data de vencimento da fatura
          amount: self.amount # Valor da fatura é o valor do contrato
        )
      end
      invoices
    end
  
    # Método auxiliar para calcular o valor da fatura
    def calculate_invoice_amount(invoice_date)
      # Agora, o valor da fatura é sempre igual ao valor do contrato
      self.amount
    end
  end
  