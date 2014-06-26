#!/usr/bin/env ruby
# encoding: UTF-8

module Smp
  class Person
    def initialize(name, prefs)
      @name = name
      @preferences = prefs
      @fiance = nil
    end
    attr_reader :name, :preferences, :fiance

    def single?
      @fiance.nil?
    end

    def engaged?
      !single?
    end

    def propose_to(person)
      if person.get_proposed_to_by(self)
        @fiance = person
      end
      #return engaged?
    end

    def get_proposed_to_by(person)
      if single?
        @fiance = person
        return true
      else
        if better_choice?(person)
          @fiance.break_up
          @fiance = person
          return true
        end
      end
      return false
    end

    def better_choice?(person)
      if person.kind_of? Person
        pname = person.name
      elsif person.kind_of? String
        pname = person
      end

      preferences.index(pname) < preferences.index(fiance.name)
    end

    def break_up
      @fiance = nil
    end

    def == other_person
      name == other_person.name
    end

  end
end
