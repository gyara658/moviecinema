class AddPostToPosterPath < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :poster_path, :string
  end
end
