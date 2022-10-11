class AddDescToStyles < ActiveRecord::Migration[7.0]
  def change
    add_column :styles, :desc, :string
  end
end
