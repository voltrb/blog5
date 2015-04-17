class BlogPost < Volt::Model
  own_by_user

  validate :title, length: 5
  validate :body, length: 20

  belongs_to :user

  permissions(:update, :delete) do
    # Only the person who created the post can delete or update it
    deny unless owner?
  end
end
