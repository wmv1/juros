class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]
  before_action :set_subscription

  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.paginate(page: params[:page], per_page: 3)
    @total_invoices_amount = @invoices.sum(:amount)
    @paid_invoices_amount =  @invoices.paid.sum(:amount)
    @pending_invoices_amount = @total_invoices_amount - @paid_invoices_amount
    @overdue_invoices_amount = 0
  end

  # GET /invoices/1 or /invoices/1.json
  def show
  end

  def pay
    @invoice = Invoice.find(params[:id])
    if @invoice.pay
      redirect_to @invoice, notice: "Fatura paga com sucesso!"
    else
      redirect_to @invoice, notice: "Erro ao processar o pagamento."
    end
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to invoices_path, status: :see_other, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_subscription
    @subscription = Subscription.find(params[:subscription_id]) if params[:subscription_id]
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.expect(invoice: [ :amount, :due_date, :paid, :subscription_id, :installment_count, :current_installment ])
    end
end
