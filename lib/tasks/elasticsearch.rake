require 'elasticsearch/rails/tasks/import'

rake environment elasticsearch:import:model CLASS='Project' FORCE=Y
