# Decidim::DecidimAiSpamBot

Automated spam moderation module for Decidim. Blocks spam users and hides spam resources based on AI detection (decidim-ai) and manual reports.

## Usage

DecidimAiSpamBot will be available as a Component for a Participatory
Space.

## Features

- Automatic blocking of users flagged as spam (AI or manual reports)
- Automatic hiding of spam resources (proposals, comments, debates...)
- Nightly scheduled job via Sidekiq-cron
- Full traceability (PaperTrail + action logs)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-decidim_ai_spam_bot"
```

And then execute:

```bash
bundle
```

## Configuration

### Sidekiq

Add the scheduler configuration to your `config/sidekiq.yml`.
See `config/sidekiq.yml.example` for the recommended configuration.

### Rake task (manual run)
```bash
bundle exec rake decidim_ai_spam_bot:block_spam_job
```

## Requirements

- [decidim-ai](https://github.com/OpenSourcePolitics/decidim-module-ai) must be installed and configured, , including `DECIDIM_AI_REPORTING_USER_EMAIL`.

## Contributing

Contributions are welcome !

We expect the contributions to follow the [Decidim's contribution guide](https://github.com/decidim/decidim/blob/develop/CONTRIBUTING.adoc).

## Security

Security is very important to us. If you have any issue regarding security, please disclose the information responsibly by sending an email to __security [at] opensourcepolitics [dot] eu__ and not by creating a GitHub issue.

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
