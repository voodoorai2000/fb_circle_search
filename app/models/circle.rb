class Circle < ActiveRecord::Base
  default_scope { order('constituted_at DESC') }

  scope :recent,   -> { where revised: false }
  scope :revised,  -> { where revised: true  }
  scope :groups,    -> { where kind: 'group'  }
  scope :pages,    -> { where kind: 'page'   }
  scope :users,     -> { where kind: 'user'   }
end
