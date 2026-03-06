module Decidim
  module Ai
    module SpamBot
      class BlockSpamUsersJob < ApplicationJob
        queue_as :default

        def perform
          SpamReportsService.new.call
        end
      end
    end
  end
end
