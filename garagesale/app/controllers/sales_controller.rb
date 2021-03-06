class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:new, :edit, :update, :destroy, :create]
  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = @current_user.sales.create
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = @current_user.sales.create(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
      respond_to do |format|
      if @sale.user_id != current_user
        format.html { redirect_to sales_url, notice: 'You do not have authorization to update the sale.' }
      elsif @sale.update(sale_params)  
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
      respond_to do |format|
        if @sale.user_id != current_user
          format.html { redirect_to sales_url, notice: 'You do not have authorization to delete the sale.' }
        else @sale.destroy
          format.html { redirect_to sales_url, notice: 'Sale was successfully deleted.' }
          format.json { head :no_content }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:title, :description, :address_line1, :address_line2, :city, :state, :posted_date, :zip_code, :image, :image_file_name, session[:user_id])
    end
end
