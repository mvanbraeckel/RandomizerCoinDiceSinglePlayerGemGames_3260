class PurchaseItemsController < ApplicationController
  # GET /purchase_items/new
  def new
    @item = Item.new
  end

  # POST /purchase_items
  # POST /purchase_items.json
  def create
    # @item = Item.new
    # respond_to do |format|
    #   if current_user.gems < 100
    #     format.html { render :new, notice: 'Params #{params}' }
    #     format.json { render json: @item.errors, status: :unprocessable_entity }
    #   end
    # end

    @item = current_user.items.create(purchase_item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to new_purchase_item_path, notice: 'Item was successfully purchased.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, notice: 'Params #{params}' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def purchase_item_params
      params.require(:item).permit(:item, :denomination, :sides, :colour, :user_id)
    end
end
