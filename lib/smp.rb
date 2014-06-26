#!/usr/bin/env ruby
# encoding: UTF-8

require 'smp/version'
require 'smp/person'

module Smp

  def self.match_couples(men, women)
    # For each man that is single, propose to women in pref list
    # starting at the top until no longer single

    men.each{|name, man| man.break_up }
    women.each{|name, woman| woman.break_up }

    while man = men.values.find { |man| man.single? }
      man.preferences.each do |name|
        break if man.propose_to(women[name])
      end
    end

  end

  def self.more_preferable_people(person)
    person.preferences.partition{ |pref| person.better_choice?(pref) }.first
  end

  # obviously this doesn't work
  def self.stability(men, women)
    better_men = Hash[women.values.map{|w| [w.name, more_preferable_people(w)] }]
    better_women = Hash[men.values.map{|m| [m.name, more_preferable_people(m)] }]

    better_women.each do |m, b_w|
      better_men.each do |w, b_m|
        return false if b_w.include?(w) && b_m.include?(m)
      end
    end

    return true
  end

end
