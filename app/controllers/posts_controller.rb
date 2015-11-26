class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @users = User.all
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path
    else
      @users = User.all
      flash.now[:notice] = "User can't be blank"
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  private
  def post_params
    params[:post].permit(:user_id, :message)
  end

  private
  def find_post
    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return head 404
    end
  end

end
