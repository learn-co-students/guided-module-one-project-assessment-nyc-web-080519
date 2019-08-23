class AddSpecialtyToProfessors < ActiveRecord::Migration[5.2]
  def change
    add_column :professors, :specialty, :string
  end
end
