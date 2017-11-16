require 'digest/md5'

class User < ApplicationRecord
  include Sluggable

  has_secure_password

  has_many :authentications, dependent: :destroy

  validates :email,
    presence: true,
    format: /.+@.+\..+/i,
    uniqueness: true

  before_validation { |user| user.email = user.email.downcase.strip }
  before_validation { |user| user.password ||= SecureRandom.hex }
  before_validation { |user| user.role ||= 'user' }

  scope :banned, -> (banned = true) {
    banned ?
      where.not(banned_at: nil) :
      where(banned_at: nil)
  }

  scope :not_banned, -> (banned = true) {
    banned ?
      where(banned_at: nil) :
      where.not(banned_at: nil)
  }

  def self.from_auth_provider(auth_params)
    user = self.find_or_initialize_by(
      email: auth_params[:email]
    )

    user.name = auth_params[:name]
    user.image_url = auth_params[:image_url]

    user.save if user.new_record?

    Authentication.find_or_create_by(
      provider: auth_params[:provider],
      uid: auth_params[:uid],
      user: user
    )

    user
  end

  def to_token_payload
    {
      sub: id,
      name: name,
      email: email,
      role: role,
      slug: slug,
      created_at: created_at,
      updated_at: updated_at
    }
  end

  def admin?
    role == 'admin'
  end

  def ban!
    update(:banned_at, Time.now)
  end

  def unban!
    update(banned_at: nil)
  end

  def gravatar_hash
    Digest::MD5.hexdigest(email)
  end
end
