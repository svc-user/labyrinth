class AddCountToRequestLogger < ActiveRecord::Migration
  def change
    add_column :request_loggers, :count, :int
  end
end
