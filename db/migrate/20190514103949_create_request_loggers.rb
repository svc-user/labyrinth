class CreateRequestLoggers < ActiveRecord::Migration
  def change
    create_table :request_loggers do |t|
      t.string :ip
      t.string :path
      t.string :url
      t.string :user_agent
      t.string :method
      t.string :post_data

      t.timestamps null: false
    end
  end
end
