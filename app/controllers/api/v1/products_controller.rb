  module Api
    module V1
      class ProductsController < ApplicationController
      # class ProductsController < ShopifyApp::AuthenticatedController
        protect_from_forgery with: :null_session
        # before_action :set_todo
        # before_action :authenticate_user!
        before_action :set_session
        # before_action :set_todo_item
        # before_action :set_todo_item_comment, only: %i[show update destroy]
        # GET /todos/:todo_id/items/:item_id/comments
        def index
          if params[:title] != 'undefined'
            @products = ShopifyAPI::Product.find(:all, params: {limit: 10, page: params[:page], title: params[:title]})
          else
            @products = ShopifyAPI::Product.find(:all, params: {limit: 10, page: params[:page]})
          end
          json_response({products: @products})
        end
        # # GET /todos/:todo_id/items/:item_id/comments/:id
        # def show
        #   json_response(@comment)
        # end
        # # POST /todos/:todo_id/items/:item_id/comments
        # def create
        #   @comment = @item.comments
        #   authorize(@comment)
        #   @comment.create!(comment_params)
        #   json_response(@comment, :created)
        # end
        # # PUT /todos/:todo_id/items/:id
        # def update
        #   @comment.update(comment_params)
        #   authorize(@comment)
        #   head :no_content
        # end
        # # DELETE /todos/:todo_id/items/:id
        # def destroy
        #   @comment.destroy
        #   authorize(@comment)
        #   head :no_content
        # end
        private
        def set_session
          @shop = Shop.where(shopify_domain: session['shopify_domain']).first
          @shop.connect_to_store
        end
      end
    end
  end
