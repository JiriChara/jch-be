class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present? && user.admin?
      can :manage, :all
    else
      can :read, Article, Article.all do |article|
        article.published? && article.published_at < Time.now.utc
      end

      can :read, Project, Project.all do |project|
        project.published? && project.published_at < Time.now.utc
      end

      can :read, Image

      can :read, Tag


      can :create, User

      can :read, User, User.all do |u|
        u.id == user.id
      end

      if user.present?
        can :read, User, id: user.id
      end
    end
  end
end
