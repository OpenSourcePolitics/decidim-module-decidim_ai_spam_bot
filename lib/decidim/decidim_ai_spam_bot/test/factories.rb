# frozen_string_literal: true

require "decidim/components/namer"
require "decidim/core/test/factories"

FactoryBot.define do
  factory :decidim_ai_spam_bot_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :decidim_ai_spam_bot).i18n_name }
    manifest_name { :decidim_ai_spam_bot }
    participatory_space { create(:participatory_process, :with_steps) }
  end

  # Add engine factories here
end
