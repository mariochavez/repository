class AddCategoryToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :category, :integer
  end

  def self.down
    remove_column :publications, :category
  end
end
