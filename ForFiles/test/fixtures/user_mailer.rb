require 'test_helper'
 
class UserMailerTest < ActionMailer::TestCase
  tests UserMailer
  test "registration_confirmation" do
    @expected.from    = 'me@example.com'
    @expected.to      = 'friend@example.com'
    @expected.subject = "You have been invited by #{@expected.from}"
    @expected.body    = read_fixture('registration_confirmation')
    @expected.date    = Time.now
    assert_equal @expected.encoded
  end
 
end
