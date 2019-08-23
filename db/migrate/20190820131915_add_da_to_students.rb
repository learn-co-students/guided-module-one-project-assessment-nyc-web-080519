class AddDaToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :dumbledores_army, :boolean
  end
end
