module Main
  class BlogController < Volt::ModelController
    before_action only: [:new, :edit] do
      require_login('Login to post')
    end

    def new
      self.model = store._blog_posts.buffer
    end

    def edit
      self.model = store._blog_posts.where(_id: params._id).fetch_first.then(&:buffer)
    end

    def show
      self.model = store._blog_posts.where(_id: params._id).fetch_first
    end

    def post
    end

    # Save the post
    def save
      model.save! do
        redirect_to '/'
      end.fail do |errors|
        flash._errors << errors.to_s
      end
    end
  end
end
