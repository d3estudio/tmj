# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string
#  nickname               :string
#  image                  :string
#  email                  :string
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string           not null
#  role                   :integer
#  mask                   :string
#

class User < ActiveRecord::Base
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :omniauthable
  
  enum role: { user: 1, editor: 2, moderator: 3, admin: 4 }
  scope :editors, -> { where(role: :editor) }
  
  # Uploader
  mount_uploader :image, AvatarUploader
  mount_uploader :mask, MaskUploader
  
  has_many :providers
  has_many :cards, through: :providers
  recommends :cards
  
  def email_required?
    false
  end
end
