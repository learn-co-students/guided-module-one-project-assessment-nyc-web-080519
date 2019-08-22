class CreatingHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :name
      t.string :colors
      t.string :values
      t.string :mascot
      t.string :house_ghost
      t.string :founder
    end
  end
end
