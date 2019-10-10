  class RecurringApplicationChargesController < ApplicationController
    before_action :load_current_recurring_charge
    # before_action :create

    def show
      @recurring_application_charge
    end

    def create_free_plan
      unless ShopifyAPI::RecurringApplicationCharge.current
        @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new({
                name: "Free Plan",
                price: 0,
                return_url: callback_recurring_application_charge_url,
                test: true,
                trial_days: 0,
                capped_amount: 100,
                terms: "10 events"},)
        if @recurring_application_charge.save
          @tokens = @recurring_application_charge.confirmation_url
          redirect_to @recurring_application_charge.confirmation_url
        end
      else
        redirect_to_correct_path(@recurring_application_charge)
      end
      # @recurring_application_charge.try!(:cancel)
    end

    def create_silver_plan
      # unless ShopifyAPI::RecurringApplicationCharge.current
          @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new({
                  name: "19 Plan",
                  price: 19,
                  return_url: callback_recurring_application_charge_url,
                  test: true,
                  trial_days: 19,
                  # capped_amount: 4.99,
                  terms: "Great things"
                },)
          if @recurring_application_charge.save
            @tokens = @recurring_application_charge.confirmation_url
            redirect_to @recurring_application_charge.confirmation_url
          end

      # else
      #   redirect_to_correct_path(@recurring_application_charge)
      # end
    end

    def create_gold_plan
      unless ShopifyAPI::RecurringApplicationCharge.current
          @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new({
                  name: "Calendar Easy Gold Plan",
                  price: 11.99,
                  return_url: callback_recurring_application_charge_url,
                  trial_days: 15,
                  capped_amount: 100,
                  terms: "unlimited events, google cal sync"},)
          if @recurring_application_charge.save
            @tokens = @recurring_application_charge.confirmation_url
            redirect_to @recurring_application_charge.confirmation_url
          end

      else
        redirect_to_correct_path(@recurring_application_charge)
      end
    end

    def customize
      @recurring_application_charge.customize(params[:recurring_application_charge])
      fullpage_redirect_to @recurring_application_charge.update_capped_amount_url
    end

    def callback
      @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(params[:charge_id])
      if @recurring_application_charge.status == 'accepted'
        @recurring_application_charge.activate
      end
      redirect_to_correct_path(@recurring_application_charge)
    end

    def destroy
      @recurring_application_charge.cancel

      flash[:success] = "Recurring application charge was cancelled successfully"

      redirect_to_correct_path(@recurring_application_charge)
    end

    private

    def load_current_recurring_charge
      @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.current
    end

    def recurring_application_charge_params
      params.require(:recurring_application_charge).permit(
        :name,
        :price,
        :capped_amount,
        :terms,
        :trial_days
      )
    end

    def redirect_to_correct_path(recurring_application_charge)
      if recurring_application_charge.try(:capped_amount)
        redirect_to home_path
      else
        redirect_to home_path
      end
    end

  end



