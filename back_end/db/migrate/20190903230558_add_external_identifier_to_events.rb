class AddExternalIdentifierToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :external_identifier, :string
  end
end
