class CreateSeos < ActiveRecord::Migration[7.2]
  def change
    create_table :seos do |t|
      t.string :name
      t.text :description
      t.string :status
      t.string :priority
      t.string :assignee
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
