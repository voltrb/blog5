class Comment < Volt::Model
  validate :name, length: 2
  validate :body, length: 10

  belongs_to :blog_post

  permissions(:update) { deny }
  permissions(:delete) do
    # Only the owner of the blog post can destroy

    blog_post.then do |blog_post|
      if blog_post.owner?
        allow
      else
        deny
      end
    end.fail do |err|
      puts "Unable to delete: #{err.inspect}"
      deny
    end
  end
end
