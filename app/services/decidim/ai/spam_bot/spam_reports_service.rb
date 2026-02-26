module Decidim
  module AI
    module SpamBot
      class SpamReportsService
        # def call
        # definir spam_user =
        # itérer sur user exept user = user.deja blocked, user.admin
        # call Decidim::Admin::BlockUser

        # methode call
        # methode users_to_block

        def user_to_block
          Decidim::User
            .joins(:user_reports)
            .where(decidim_user_reports: {reason: "spam"})
            .where(admin: false)
            .where(deleted_at: nil)
            .where(blocked: false)
            .distinct
        end
        #   Sélectionner les users :
        #   ayant au moins un UserReport
        #   avec reason = "spam"
        #   Exclure :
        #   users déjà bloqués
        #   admins
        #   users supprimés (deleted_at présent)
        #   Retourner une liste distincte de users
        #
        # methode block_user

        #   Construire un BlockUserForm avec :
        #   users_to_block
        #   current_user = system_user
        #   justification automatique
        #   hide = true (ou false selon choix V0)
        #    Exécuter la command Decidim::Admin::BlockUser

        #
        # methode build_block_form
        #
        # methode system_user
        #

      end
    end
  end
end
