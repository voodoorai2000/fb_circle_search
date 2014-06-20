class Circle < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  scope :recent,   -> { where revised: false }
  scope :revised, -> { where revised: true }

end
