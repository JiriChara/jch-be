class Ability
  include CanCan::Ability

  def initialize(user)
    # Guests

    can :read, Article, Article.all do |article|
      article.published? && article.published_at < Time.now.utc
    end

    can :read, Tag

    can :read, Project

    can :create, User

    return unless user.present?

    # Logged-in users

    can :read, User, id: user.id

    return unless user.admin?

    # Admins

    can :manage, :all
  end
end
