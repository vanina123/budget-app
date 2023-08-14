class Records < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.references :category, null: false, foreign_key: true, index: true
      t.references :expenditure, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
