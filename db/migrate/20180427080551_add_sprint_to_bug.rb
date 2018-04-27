class AddSprintToBug < ActiveRecord::Migration[5.0]
  def change
    add_reference :bugs, :sprint, foreign_key: true
  end
end
