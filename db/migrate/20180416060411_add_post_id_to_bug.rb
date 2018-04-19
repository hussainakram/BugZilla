class AddPostIdToBug < ActiveRecord::Migration[5.0]
  def change
    add_column :bugs, :post_id, :string
  end
end
