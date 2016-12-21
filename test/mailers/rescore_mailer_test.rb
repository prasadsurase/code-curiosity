require "test_helper"

class RescoreMailerTest < ActionMailer::TestCase
  include ActiveJob::TestHelper

  def setup
    super
    @round = create :round, :open
    @user = create(:user, is_judge: true)
    @commit = create(:commit, user: @user, message: Faker::Lorem.sentences, sha: 'eb0df748bbf084ca522f5ce4ebcf508d16169b96',
                     repository: create(:repository, owner: 'joshsoftware', name: 'code-curiosity'))
  end

  def test_mail_is_enqueued_to_be_delivered_later
    assert_enqueued_jobs 1 do
      RescoreMailer.notify_judge(@commit.class.name, @commit.id.to_s, @user.email).deliver_later
    end
  end

  def test_mail_should_be_delivered
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      RescoreMailer.notify_judge(@commit.class.name, @commit.id.to_s, @user.email).deliver_now
    end
  end

  def test_mail_is_delivered_with_expected_content
    perform_enqueued_jobs do
      mail = RescoreMailer.notify_judge(@commit.class.name, @commit.id.to_s, @user.email).deliver_now
      delivered_email = ActionMailer::Base.deliveries.last
      assert_equal delivered_email.to, mail.to
    end
  end

end
