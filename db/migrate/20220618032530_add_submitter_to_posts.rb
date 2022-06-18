class AddSubmitterToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :submitter, :integer
  end
end
