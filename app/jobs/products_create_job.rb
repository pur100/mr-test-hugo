  class ProductsCreateJob < ApplicationJob
    queue_as :default

    def perform(*params)
      p "____________CreateJob___________________"
     # Do something later
    end
  end
