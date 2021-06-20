class PostsController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create]

    def index
      if params[:search] == nil
        @posts = Post.all.page(params[:page]).per(10)
        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(10)
      elsif params[:search] == ''
        @posts = Post.all.page(params[:page]).per(10)
        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(10)
      else  
        @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
      end
    end
  
    def new
      @post = Post.new
    end

    def create
        post = Post.new(post_params)
        post.user_id = current_user.id
        if post.save
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
    end
    
      def show
        @post = Post.find(params[:id])
      end

      def edit
        @post = Post.find(params[:id])
      end
    
        def update
        post = Post.find(params[:id])
        if post.update(post_params)
          redirect_to :action => "show", :id => post.id
        else
          redirect_to :action => "new"
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :index
      end

  

    private
  def post_params
    params.require(:post).permit(:word, :speaker, :about, :image, tag_ids: [])
  end

end

