#!/usr/bin/env ruby
# encoding: UTF-8

require 'minitest_helper'

describe Smp::Person do
  let(:pname) { 'larry' }
  let(:prefs) { %w(mary jane watson) }
  let(:mary_prefs) { %w(larry curly moe) }
  let(:larry) { Smp::Person.new(pname, prefs) }
  let(:mary) { Smp::Person.new('mary', mary_prefs) }
  let(:moe) { Smp::Person.new('moe', prefs) }

  it "has a name" do
    larry.name.must_equal(pname)
  end

  it "has preferences" do
    larry.preferences.must_equal(prefs)
  end

  it "has an engaged status that returns true if engaged, false otherwise" do
    larry.engaged?.must_equal(false)
    larry.propose_to(mary)
    larry.engaged?.must_equal(true)
    mary.engaged?.must_equal(true)
  end

  it "has a #fiance that returns the Person engaged do, or nil" do
    larry.fiance.must_equal(nil)
    larry.propose_to(mary)
    larry.fiance.must_equal(mary)
    mary.fiance.must_equal(larry)
  end

  it "should test equality by name" do
    larry.must_equal(larry.dup)
    larry.wont_equal(moe)
    larry.wont_equal(mary)
  end

  it "should not get engaged if it proposes to someone already engaged to a more preffered match" do
    larry.propose_to(mary)
    mary.fiance.must_equal(larry)
    moe.propose_to(mary)
    mary.fiance.must_equal(larry)
  end

  it "should get engaged to a person of higher preference when already engaged" do
    moe.propose_to(mary)
    mary.fiance.must_equal(moe)
    larry.propose_to(mary)
    mary.fiance.must_equal(larry)

    larry.fiance.must_equal(mary)
    moe.fiance.must_equal(nil)
  end

end
