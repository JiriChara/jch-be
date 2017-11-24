require 'digest/md5'

class User < ApplicationRecord
  has_many :articles

  include Sluggable

  has_secure_password

  validates :email,
    presence: true,
    format: /.+@.+\..+/i,
    uniqueness: true

  before_validation { |user| user.email = user.email.downcase.strip }
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

  def self.from_token_request(request)
    email = request.params['auth'] && request.params['auth']['email']
    self.find_by email: email.downcase.strip
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
