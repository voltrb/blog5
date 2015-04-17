module Main
  class CommentController < Volt::ModelController
    def new
      self.model = attrs.blog_post._comments.buffer
    end

    def save
      model.save!.then do
        flash._notices << "Comment Added"
        new
      end.fail do |err|
        flash._notices << err.to_s
      end
    end
  end
end
