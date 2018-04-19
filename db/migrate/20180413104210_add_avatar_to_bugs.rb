class AddAvatarToBugs < ActiveRecord::Migration[5.0]
  def change
    add_column :bugs, :avatar, :string
  end
end
