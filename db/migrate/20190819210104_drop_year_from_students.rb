class DropYearFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :year
  end
end
