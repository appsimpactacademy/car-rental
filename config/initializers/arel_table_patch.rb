# config/initializers/arel_table_patch.rb
module Arel
  class Table
    alias :table_name :name
  end
end
