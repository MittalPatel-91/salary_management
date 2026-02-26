class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :full_name, null: false
      t.string :job_title, null: false
      t.string :country, null: false
      t.decimal :salary, null: false, precision: 15, scale: 2

      t.timestamps
    end
    add_index :employees, :country
    add_index :employees, :job_title
  end
end
