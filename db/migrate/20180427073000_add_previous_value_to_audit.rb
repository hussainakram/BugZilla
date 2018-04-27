class AddPreviousValueToAudit < ActiveRecord::Migration[5.0]
  def change
    add_column :audits, :previous_value, :string
  end
end
