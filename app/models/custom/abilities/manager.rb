require_dependency Rails.root.join("app", "models", "abilities", "manager").to_s

module Abilities
  class Manager
    alias_method :consul_initialize, :initialize

    def initialize(user)
      consul_initialize(user)

      can :verify, ::User
    end
  end
end
