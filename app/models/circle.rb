class Circle < ActiveRecord::Base
  default_scope { order('constituted_at IS NULL, constituted_at DESC') }

  scope :recent,   lambda { |time_ago| where("constituted_at > ?", time_ago) }
  scope :revised,  -> { where revised: true  }
  scope :groups,   -> { where kind: 'group'  }
  scope :pages,    -> { where kind: 'page'   }
  scope :users,    -> { where kind: 'user'   }
end
