# frozen_string_literal: true

base_path = File.expand_path("..", __dir__)

Decidim::Webpacker.register_path("#{base_path}/app/packs")
Decidim::Webpacker.register_entrypoints(
  decidim_decidim_ai_spam_bot: "#{base_path}/app/packs/entrypoints/decidim_decidim_ai_spam_bot.js"
)
Decidim::Webpacker.register_stylesheet_import("stylesheets/decidim/decidim_ai_spam_bot/decidim_ai_spam_bot")
