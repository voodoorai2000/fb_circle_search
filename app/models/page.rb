class Page < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  scope :fresh,   -> { where revised: false }
  scope :revised, -> { where revised: true }
end
