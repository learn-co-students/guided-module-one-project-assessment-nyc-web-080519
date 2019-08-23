class AddHouseIdToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :house_id, :integer
  end
end
