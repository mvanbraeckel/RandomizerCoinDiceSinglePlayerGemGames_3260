class PurchaseItemsController < ApplicationController
  # GET /purchase_items/new
  def purchase_items
    @item = Item.new
  end

  # POST /purchase_items
  # POST /purchase_items.json
  def create_purchased_item
    @item = current_user.items.create(purchase_item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to user_item_path(current_user, @item), notice: 'Item was successfully purchased.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
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
