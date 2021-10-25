class ItemsController < ApplicationController
  before_action :set_user
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :set_user, only: [:purchase_items]
  skip_before_action :set_item, only: [:purchase_items]

  # GET /items
  # GET /items.json
  def index
    @items = @user.items
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # for the purchase items page
  def purchase_items
    @item = Item.new
  end

  def create_purchased_item
    @item = current_user.items.create(item_params)

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

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = @user.items.create(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to user_item_path(@user, @item), notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to user_item_path(@user, @item), notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    # @item = @user.items.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.html { redirect_to user_items_path(@user), notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end
    def set_item
      @item = Item.find(params[:id])
      # @item = @user.items.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:item, :denomination, :sides, :colour, :user_id)
    end
end
