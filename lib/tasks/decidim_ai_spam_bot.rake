namespace :decidim_ai_spam_bot do
  desc "Block spam users and hide spam resources (=contents) based on AI detection, and manual, reports"
  task block_spam_job: :environment do
    Decidim::Ai::SpamBot::BlockSpamJob.perform_later
  end
end
