# frozen_string_literal: true

# :nodoc:
class PostsController < ApplicationController
  before_action :find_post, only: %w[show edit update destroy]
  before_action :authenticate_user!, except: %w[index show]
  before_action :admin?, except: %w[index show]

  def index
    @posts = Post.all.order("created_at DESC").paginate(page: params[:page])
    @top = Post.all.order("views DESC").take(3)
  end

  def show
    @post.update(views: @post.views + 1)
    @comments = @post.comments.order('created_at DESC')
    @num_of_comments = @post.num_of_comments
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do
      if @post.update(post_params)
        redirect_to @post
      else
        render :edit
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.friendly.find(params[:id])
  end

  def admin?
    redirect_to root_path unless current_user&.admin
  end

  def post_params
    params.require(:post).permit(:title, :body, :picture, :banner)
  end
end
