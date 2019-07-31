class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string  :tracker_type
      t.string  :summary
      t.string  :description
      t.date    :date
      t.integer :duration

      t.timestamps
    end
  end
end
