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
          form = Decidim::Admin::BlockUserForm.new(

              user_id: user.id,
              justification: "Automatic block from AI spam report",
              hide: false
          )

          form.current_user = system_user,
          form.current_organization = user.organization

          Decidim::Admin::BlockUser.call(form)
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
