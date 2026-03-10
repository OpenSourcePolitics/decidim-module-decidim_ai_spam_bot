module Decidim
  module Ai
    module SpamBot
      class BlockSpamJob < ApplicationJob
        queue_as :default

        def perform
          SpamReportsService.new.call
        end
      end
    end
  end
end
