#!/usr/bin/env ruby
# encoding: UTF-8

require 'minitest_helper'

describe Smp do
  it "has a version number" do
    refute_nil ::Smp::VERSION
  end

  let(:prefs) do
    {
      'abe'  => %w[abi eve cath ivy jan dee fay bea hope gay],
      'bob'  => %w[cath hope abi dee eve fay bea jan ivy gay],
      'col'  => %w[hope eve abi dee bea fay ivy gay cath jan],
      'dan'  => %w[ivy fay dee gay hope eve jan bea cath abi],
      'ed'   => %w[jan dee bea cath fay eve abi ivy hope gay],
      'fred' => %w[bea abi dee gay eve ivy cath jan hope fay],
      'gav'  => %w[gay eve ivy bea cath abi dee hope jan fay],
      'hal'  => %w[abi eve hope fay ivy cath jan bea gay dee],
      'ian'  => %w[hope cath dee gay bea abi fay ivy jan eve],
      'jon'  => %w[abi fay jan gay eve bea dee cath ivy hope],
      'abi'  => %w[bob fred jon gav ian abe dan ed col hal],
      'bea'  => %w[bob abe col fred gav dan ian ed jon hal],
      'cath' => %w[fred bob ed gav hal col ian abe dan jon],
      'dee'  => %w[fred jon col abe ian hal gav dan bob ed],
      'eve'  => %w[jon hal fred dan abe gav col ed ian bob],
      'fay'  => %w[bob abe ed ian jon dan fred gav col hal],
      'gay'  => %w[jon gav hal fred bob abe col ed dan ian],
      'hope' => %w[gav jon bob abe ian dan hal ed col fred],
      'ivy'  => %w[ian col hal gav fred bob abe ed jon dan],
      'jan'  => %w[ed hal gav abe bob jon col ian fred dan],
    }
  end

  let(:men) do
    Hash[
      %w[abe bob col dan ed fred gav hal ian jon].collect do |name|
        [name, Smp::Person.new(name, prefs[name])]
      end
    ]
  end

  let(:women) do
    Hash[
      %w[abi bea cath dee eve fay gay hope ivy jan].collect do |name|
        [name, Smp::Person.new(name, prefs[name])]
      end
    ]
  end

  it "should match couples into a stable matching" do
    Smp.match_couples(men, women)
    Smp.stability(men, women).must_equal(true)

    # Swap fiance's to prove stability
    w1 = men['abe'].fiance
    w2 = men['bob'].fiance
    men['abe'].instance_variable_set(:fiance, w2)
    men['bob'].instance_variable_set(:fiance, w1)

    Smp.stability(men, women).must_equal(false)
  end

end
