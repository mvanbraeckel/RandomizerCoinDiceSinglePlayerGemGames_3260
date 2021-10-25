class PurchaseItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /purchase_items/1
  # GET /purchase_items/1.json
  def show
  end

  # GET /purchase_items/new
  def new
    @item = Item.new
  end

  # POST /purchase_items
  # POST /purchase_items.json
  def create
    @item = Item.new(purchase_item_params)

    item_cost = 2

    # if params[:item] == "coin" || params[:item] == :coin
    #   @item = current_user.items.create(item: params[:item], denomination: params[:denomination])
    # elsif params[:item] == "die" || params[:item] == :die
    #   item_cost = @item.sides
    #   @item = current_user.items.create(item: params[:item], sides: params[:sides], colour: params[:colour])
    # end

    if @item.item == "coin" || @item.item == :coin
      current_user.items.create(purchase_coin_params)
    elsif @item.item == "die" || @item.item == :die
      item_cost = @item.sides
      current_user.items.create(purchase_die_params)
    end

    # @item = current_user.items.create(purchase_item_params)

    if !item_cost
      flash.now[:alert] = "Purchase refused. Please input a number of sides for the die you want to purchase."
      render :new
    elsif current_user.gems < item_cost
      flash.now[:alert] = "Purchase refused. You don't have enough gems. The item costs #{item_cost}, but you only have #{current_user.gems} gems."
      render :new
    else
      current_user.gems -= item_cost

      respond_to do |format|
        if current_user.save && @item.save
          format.html { redirect_to new_purchase_item_path, notice: 'Item was successfully purchased.' }
          format.json { render :show, status: :created, location: @item }
        else
          format.html { render :new }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = current_user.items.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_item_params
      params.require(:item).permit(:item, :denomination, :sides, :colour, :user_id)
    end
    def purchase_coin_params
      params.require(:item).permit(:item, :denomination, :user_id)
    end
    def purchase_die_params
      params.require(:item).permit(:item, :sides, :colour, :user_id)
    end
end
