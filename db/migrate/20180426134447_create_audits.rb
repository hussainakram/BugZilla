class CreateAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :audits do |t|
      t.references :user, foreign_key: true
      t.references :bug, foreign_key: true
      t.string :changed_attribute
      t.string :action_performed
      t.integer :version

      t.timestamps
    end
  end
end
