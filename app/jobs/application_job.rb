  class ApplicationJob < ActiveJob::Base
    def session_api(shop_domain)
      @shop = Shop.where(shopify_domain: shop_domain).first
      @shop.connect_to_store
    end
  end

