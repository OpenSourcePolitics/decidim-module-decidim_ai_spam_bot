# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", "~> 0.29"
gem "decidim-decidim_ai_spam_bot", path: "."

gem "bootsnap", "~> 1.4"
gem "puma", ">= 6.3.1"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", "~> 0.31"
end

group :development do
  gem "faker", "3.2.1"
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "web-console", "~> 4.2"
end
