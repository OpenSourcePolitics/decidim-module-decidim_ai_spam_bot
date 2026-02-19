# frozen_string_literal: true

module Decidim
  module DecidimAiSpamBot
    # This is the engine that runs on the public interface of `DecidimAiSpamBot`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::DecidimAiSpamBot::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :decidim_ai_spam_bot do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "decidim_ai_spam_bot#index"
      end

      def load_seed
        nil
      end
    end
  end
end
