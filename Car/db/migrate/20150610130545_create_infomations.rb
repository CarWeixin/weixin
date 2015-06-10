class CreateInfomations < ActiveRecord::Migration
  def change
    create_table :infomations do |t|
    	t.string :name 
    	t.string :phone
    	t.string :start_time 
    	t.string :start
    	t.string :end 
    	t.string :driver
      t.timestamps
    end
  end
end
