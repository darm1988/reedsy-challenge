class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_item, only: [:update]

  def index
    render json: Item.all
  end

  def update
    @item.update!(item_params)

    render json: @item
  end

  def checkout
    list = params[:items]&.split(',')
    total = 0

    if list.present?
    end

    render json: { total: total }
  end

  private

  def find_item
    item_id = params[:id]
    @item = Item.find(item_id)
  end

  def item_params
    params.permit(:price)
  end
end
