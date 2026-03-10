module Decidim
  module Ai
    module SpamBot
      class SpamReportsService

        def call # orchestre
          user_to_block.find_each do |user|
            block_user(user)
          end
        end

        def user_to_block
          Decidim::User
            .joins(:user_reports)
            .where(decidim_user_reports: {reason: "spam"})
            .where(admin: false)
            .where(deleted_at: nil)
            .where(blocked: false)
            .distinct
        end

        def block_user(user)
          form = Decidim::Admin::BlockUserForm
            .from_params(
              user_id: user.id,
              justification: "Automatic block from manual and AI spam reports",
              hide: false
            )
            .with_context(
              current_user: system_user,
              current_organization: user.organization
            )
          Decidim::Admin::BlockUser.call(form)
        end

        def spam_resources
          Decidim::Moderation
            .joins(:reports)
            .where(decidim_reports: { reason: "spam" })
            .where(hidden_at: nil)
        end

        def hide_spam_resources
          spam_resources.find_each do |moderation|
            reportable = moderation.reportable
            next if reportable.nil?
            Decidim::Admin::HideResource.new(reportable, system_user, with_admin_log: false).call
          end
        end

        def system_user
          @system_user ||= Decidim::UserBaseEntity.find_by!(
            email:ENV['DECIDIM_AI_REPORTING_USER_EMAIL']
          )
        end
      end
    end
  end
end
