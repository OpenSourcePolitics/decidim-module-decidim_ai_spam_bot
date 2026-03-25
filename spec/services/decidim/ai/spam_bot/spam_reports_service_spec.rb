# frozen_string_literal: true

require "spec_helper"

describe Decidim::Ai::SpamBot::SpamReportsService do
  subject { described_class.new }

  let!(:organization) { create(:organization) }
  let!(:system_user) { create(:user, email: reporting_user_email, organization: organization) }
  let(:reporting_user_email) { "spam-bot@example.org" }

  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("DECIDIM_AI_REPORTING_USER_EMAIL", nil).and_return(reporting_user_email)
    allow(ENV).to receive(:[]).with("DECIDIM_AI_ENABLED", "false").and_return("true")
  end

  describe "#spam_users" do
    let!(:spam_user) do
      user = create(:user, organization: organization)
      moderation = create(:user_moderation, user: user)
      create(:user_report, moderation: moderation, user: system_user, reason: "spam")
      user
    end

    let!(:clean_user) { create(:user, organization: organization) }

    let!(:blocked_user) do
      user = create(:user, :blocked, organization: organization)
      moderation = create(:user_moderation, user: user)
      create(:user_report, moderation: moderation, user: system_user, reason: "spam")
      user
    end

    it "returns users with spam reports" do
      expect(subject.spam_users).to include(spam_user)
    end

    it "does not return users without spam reports" do
      expect(subject.spam_users).not_to include(clean_user)
    end

    it "does not return already blocked users" do
      expect(subject.spam_users).not_to include(blocked_user)
    end

    it "does not return admin users" do
      admin = create(:user, :admin, organization: organization)
      moderation = create(:user_moderation, user: admin)
      create(:user_report, moderation: moderation, user: system_user, reason: "spam")
      expect(subject.spam_users).not_to include(admin)
    end
  end

  describe "#spam_resources" do
    let!(:component) { create(:component, organization: organization) }

    let!(:spam_moderation) do
      moderation = create(:moderation, reportable: create(:dummy_resource, component: component), report_count: 1)
      create(:report, moderation: moderation, user: system_user, reason: "spam")
      moderation
    end

    let!(:hidden_moderation) do
      moderation = create(:moderation, :hidden, reportable: create(:dummy_resource, component: component), report_count: 1)
      create(:report, moderation: moderation, user: system_user, reason: "spam")
      moderation
    end

    it "returns moderations with spam reports not yet hidden" do
      expect(subject.spam_resources).to include(spam_moderation)
    end

    it "does not return already hidden moderations" do
      expect(subject.spam_resources).not_to include(hidden_moderation)
    end
  end

  describe "#call" do
    let!(:spam_user) do
      user = create(:user, organization: organization)
      moderation = create(:user_moderation, user: user)
      create(:user_report, moderation: moderation, user: system_user, reason: "spam")
      user
    end

    it "blocks spam users" do
      subject.call
      expect(spam_user.reload.blocked?).to be true
    end
  end
end
