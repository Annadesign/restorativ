class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.string :title
      t.text :description
      t.integer :position
      t.boolean :ispublished

      t.timestamps
    end
  end
end
