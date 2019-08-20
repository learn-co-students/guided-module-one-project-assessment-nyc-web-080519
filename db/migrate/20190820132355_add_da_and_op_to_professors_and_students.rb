class AddDaAndOpToProfessorsAndStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :order_of_the_phoenix, :boolean
    add_column :professors, :order_of_the_phoenix, :boolean
    add_column :professors, :dumbledores_army, :boolean
  end
end
