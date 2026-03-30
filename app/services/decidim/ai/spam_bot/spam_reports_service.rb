# frozen_string_literal: true

module Decidim
  module Ai
    module SpamBot
      class SpamReportsService
        def call
          block_spam_users
          hide_spam_resources
        end

        def spam_users
          Decidim::User
            .joins(:user_reports)
            .where(decidim_user_reports: { reason: "spam" })
            .where(admin: false)
            .where(deleted_at: nil)
            .where(blocked: false)
            .where.not(id: manually_unblocked_user_ids)
            .distinct
        end

        def manually_unblocked_user_ids
          Decidim::ActionLog
            .where(action: "unblock", resource_type: "Decidim::User")
            .pluck(:resource_id)
        end

        def block_spam_users
          spam_users.find_each do |user|
            form = Decidim::Admin::BlockUserForm
                   .from_params(
                     user_id: user.id,
                     justification: I18n.t("decidim.ai.spam_bot.block_user.justification"),
                     hide: false
                   )
                   .with_context(
                     current_user: system_user,
                     current_organization: user.organization
                   )
            Decidim::Admin::BlockUser.call(form)
          end
        end

        def spam_resources
          Decidim::Moderation
            .joins(:reports)
            .where(decidim_reports: { reason: "spam" })
            .where(hidden_at: nil)
            .where.not(id: manually_unhidden_resource_ids)
        end

        def manually_unhidden_resource_ids
          Decidim::ActionLog
            .where(action: "unhide", resource_type: "Decidim::Moderation")
            .pluck(:resource_id)
        end

        def hide_spam_resources
          spam_resources.find_each do |moderation|
            reportable = moderation.reportable
            next if reportable.nil?

            Decidim::Admin::HideResource.new(reportable, system_user).call
          end
        end

        def system_user
          @system_user ||= Decidim::UserBaseEntity.find_by!(
            email: ENV["DECIDIM_AI_REPORTING_USER_EMAIL"]
          )
        end
      end
    end
  end
end
