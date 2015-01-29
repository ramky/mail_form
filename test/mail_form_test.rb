require 'test_helper'
require 'fixtures/sample_mail'

class MailFormTest < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, MailForm
  end

  test 'sample mail has name and email as attributes' do
    sample = SampleMail.new
    sample.name = 'User'
    sample.email = 'user@example.com'

    assert_equal 'User', sample.name
    assert_equal 'user@example.com', sample.email
  end

  test 'sample mail can clear attributes using clear_ prefix' do
    sample = SampleMail.new
    sample.name = 'User'
    sample.email = 'user@example.com'

    sample.clear_name
    sample.clear_email

    assert_nil sample.name
    assert_nil sample.email
  end

  test 'delivers an email with attributes' do
    sample        = SampleMail.new
    email_address = 'user@example.com'
    sample.email  = email_address

    sample.deliver
    mail = ActionMailer::Base.deliveries.last

    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_equal [ email_address ], mail.from
    assert_match "Email: #{email_address}", mail.body.encoded
  end
end
