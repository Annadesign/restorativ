class AddIspublishedToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :ispublished, :boolean
  end
end
