class RedditCommentsController < ApplicationController
  before_action :set_reddit_comment, only: [:show, :edit, :update, :destroy]

  # GET /reddit_comments
  # GET /reddit_comments.json
  def index
    @reddit_comments = RedditComment.all
  end

  # GET /reddit_comments/1
  # GET /reddit_comments/1.json
  def show
  end

  # GET /reddit_comments/new
  def new
    @reddit_comment = RedditComment.new
  end

  # GET /reddit_comments/1/edit
  def edit
  end

  # POST /reddit_comments
  # POST /reddit_comments.json
  def create
    @reddit_comment = RedditComment.new(reddit_comment_params)

    respond_to do |format|
      if @reddit_comment.save
        format.html { redirect_to @reddit_comment, notice: 'Reddit comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @reddit_comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @reddit_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reddit_comments/1
  # PATCH/PUT /reddit_comments/1.json
  def update
    respond_to do |format|
      if @reddit_comment.update(reddit_comment_params)
        format.html { redirect_to @reddit_comment, notice: 'Reddit comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reddit_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reddit_comments/1
  # DELETE /reddit_comments/1.json
  def destroy
    @reddit_comment.destroy
    respond_to do |format|
      format.html { redirect_to reddit_comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reddit_comment
      @reddit_comment = RedditComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reddit_comment_params
      params.require(:reddit_comment).permit(:comment_text, :sentiment)
    end
end
