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
    if @item.item == "die" || @item.item == :die
      item_cost = @item.sides
    end

    if current_user.gems < item_cost
      flash.now[:alert] = "Purchase refused. You don't have enough gems. The item costs #{item_cost}, but you only have #{current_user.gems} gems."
      render :new
    else # current_user.gems >= item_cost
      current_user.gems -= item_cost
      @item = current_user.items.create(purchase_item_params)

      respond_to do |format|
        if current_user.save && @item.save
          format.html { redirect_to purchase_item_path(@item), notice: 'Item was successfully purchased.' }
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
end
