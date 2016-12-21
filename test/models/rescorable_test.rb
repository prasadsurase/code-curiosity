require 'test_helper'

class DummyTest
  include Mongoid::Document
  include Rescorable
end

class GoalTest < ActiveSupport::TestCase
  def setup
    super
    @rescorable = DummyTest.new
    @rescorable.extend(Rescorable)
  end

  test 'fields' do
    assert @rescorable.respond_to? :new_score
    assert @rescorable.respond_to? :dev_comment
    assert @rescorable.respond_to? :judge_comment
    assert @rescorable.respond_to? :aasm_state
  end

  test "initial state is 'new'" do
    assert @rescorable.new?
  end

  test 'states' do
    assert @rescorable.new?
    refute @rescorable.submitted?
    refute @rescorable.accepted?
    refute @rescorable.rejected?
  end

  test 'submit transition' do
    assert @rescorable.new?
    @rescorable.submit!
    assert @rescorable.submitted?
  end

  test 'accept transition' do
    assert @rescorable.new?
    @rescorable.submit!
    @rescorable.accept!
    assert @rescorable.accepted?
  end

  test 'reject transition' do
    assert @rescorable.new?
    @rescorable.submit!
    assert @rescorable.reject!
    assert @rescorable.rejected?
  end

end
