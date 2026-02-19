# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module DecidimAiSpamBot
    # This is the engine that runs on the public interface of decidim_ai_spam_bot.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::DecidimAiSpamBot

      routes do
        # Add engine routes here
        # resources :decidim_ai_spam_bot
        # root to: "decidim_ai_spam_bot#index"
      end

      initializer "DecidimAiSpamBot.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
