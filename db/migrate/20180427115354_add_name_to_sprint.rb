class AddNameToSprint < ActiveRecord::Migration[5.0]
  def change
    add_column :sprints, :name, :string
    add_column :audits, :new_value, :string
  end
end
