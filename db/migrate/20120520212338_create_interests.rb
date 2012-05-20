class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :email
      t.string :item

      t.timestamps
    end
  end
end
