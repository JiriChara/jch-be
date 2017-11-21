class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present? && user.admin?
      can :manage, :all
    else
      can :read, Article, Article.all do |article|
        article.published? && article.published_at < Time.now.utc
      end

      can :read, Tag

      can :read, Project

      can :create, User

      if user.present?
        can :read, User, id: user.id
      end
    end
  end
end
