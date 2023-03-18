class ItemsController < ApplicationController


  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user
        items = user.items 
        render json: items, include: :user
      else
        render json: {error: "User not found"}, status: :not_found
      end
    else 
      items = Item.all 
      render json: items, include: :user
    end
  end

  def show
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user 
        item = user.items.find_by(id: params[:id])
        if item 
          render json: item, include: :user
        else
          render json: {error: "Item not found"}, status: :not_found
        end
      else 
        render json: {error: "User not found"}, status: :not_found
      end
    else 
      item = Item.find_by(id: params[:id])
      if item 
        render json: item, include: :user
      else 
        render json: {error: "Item not found"}, status: :not_found
      end
    end
  end

  def create 
    # item = Item.create(item_params)
    # render json: item, include: :user
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user 
        item = user.items.create(item_params)
        render json: item, status: :created
      else 
        render json: { error: "Item not created" }, status: :unprocessable_entity
      end
    end
  end
  
  private 
  
  def item_params 
    params.permit(:name, :description, :price)
  end
  
  


end
