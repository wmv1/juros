class ContractsController < ApplicationController
  before_action :set_contract, only: %i[ show edit update destroy ]

  # GET /contracts or /contracts.json
  def index
    @contracts = Contract.all
    @paginated_invoices = nil
  end

  # GET /contracts/1 or /contracts/1.json
  def show
    @contract = Contract.find(params[:id])
    @subscriptions = @contract.subscriptions.includes(:invoices)

    # Paginar as faturas associadas às assinaturas
    @paginated_invoices = Invoice.where(subscription_id: @subscriptions.ids)
                                .paginate(page: params[:page], per_page: 5)
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts or /contracts.json
  def create
    @contract = Contract.new(contract_params)

    respond_to do |format|
      if @contract.save
        
        format.html { redirect_to @contract, notice: "Contract was successfully created." }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1 or /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: "Contract was successfully updated." }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1 or /contracts/1.json
  def destroy
    @contract.destroy!

    respond_to do |format|
      format.html { redirect_to contracts_path, status: :see_other, notice: "Contract was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def contract_params
      params.expect(contract: [ :number, :name, :customer_id, :start_date, :end_date ])
    end
end
