class DropAgeAndSpecialtyFromProfessors < ActiveRecord::Migration[5.2]
  def change
    remove_column :professors, :age
    remove_column :professors, :specialty
    remove_column :professors, :tenure
  end
end
