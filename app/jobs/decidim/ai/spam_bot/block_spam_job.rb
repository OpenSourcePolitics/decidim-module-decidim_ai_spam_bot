# frozen_string_literal: true

module Decidim
  module Ai
    module SpamBot
      class BlockSpamJob < ApplicationJob
        queue_as :default

        def perform
          return unless decidim_ai_enabled?

          SpamReportsService.new.call
        end

        private

        def decidim_ai_enabled?
          ENV.fetch("DECIDIM_AI_ENABLED", "false") == "true"
        end
      end
    end
  end
end
