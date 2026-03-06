namespace :decidim_ai_spam_bot do
  desc "Block spam users based on AI detection and manual reports"
  task block_spam_users_job: :environment do
    puts "[#{Time.current}] BlockSpamUsersJob"
    Decidim::Ai::SpamBot::BlockSpamUsersJob.perform_later
    puts "[#{Time.current}] BlockSpamUsersJob finished"
  end
end
