    # frozen_string_literal: true
    class HomeController < ShopifyApp::AuthenticatedController
      layout "application"
      before_action :set_plan
      before_action :protect_plan, except: :index

      def home
        @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
        @webhooks = ShopifyAPI::Webhook.find(:all)
      end

      def index
        if session["shopify"]
          @shop = Shop.find(session["shopify"])
        else
          redirect_to shopify_app_url
        end

        if @plan
          redirect_to home_url
        end
      end

      private

      def set_plan
        @plan = ShopifyAPI::RecurringApplicationCharge.current
      end

      def protect_plan
        if !@plan
          redirect_to root_url
        end
      end
    end








