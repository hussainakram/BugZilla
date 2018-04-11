class CreateBugs < ActiveRecord::Migration[5.0]
  def change
    create_table :bugs do |t|
      t.string :title, unique: true
      t.text :description
      t.date :deadline
      t.string :type
      t.string :status
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
    add_index :bugs, :title, unique: true
  end
end
