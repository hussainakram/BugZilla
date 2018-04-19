class AddAssigntoToBug < ActiveRecord::Migration[5.0]
  def change
    add_column :bugs, :assign_to, :integer
  end
end
