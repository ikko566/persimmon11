# coding: utf-8
class TranscriptsController < ApplicationController
  before_action :set_transcript, only: [:show, :edit, :update, :destroy]

  # GET /transcripts
  # GET /transcripts.json
  def index
    @transcripts = Transcript.all
    list
   render :action=>'list'
  end
  #GET should be safe ( see http://www.w3.org/2001/tag/doc/WhenToUseGet.html
#  verify :method=> :post, :only => [ :destroy, :create, :update ], :redirect_to => {:action => :list }
  def destroy
    Transcript.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def get_transcript
    @transcript = Transcript.find(params[:id])
    send_data(@transcript.file, :filename=> @transcript.filename, :type=>@transcript.content_type,:disposition=>"inline")
  end



  # GET /transcripts/1
  # GET /transcripts/1.json
  def show
  end

  def list
      @transcript_pages = @transcripts.paginate( :page => params[:page], :per_page=>3 )
#      @transcript_pages, @transcripts=paginate :transcripts, :per_page=>10
      get_taglist
  end

  def tagsearch
    if params[:tag] then
      @transcript_pages = @transcripts.paginate( :page => params[:page], :per_page=>3, 
                          :conditions=>["tag=?",params[:tag]] )
    else
      @transcript_pages = @transcripts.paginate( :page => params[:page], :per_page=>3 )
    end

    get_taglist
    render  :action => 'list'
  end

  # GET /transcripts/new
  def new
    @transcript = Transcript.new
  end

  # GET /transcripts/1/edit
  def edit
  end

  # POST /transcripts
  # POST /transcripts.json
  def create
    @transcript = Transcript.new(transcript_params)

#    respond_to do |format|
      if @transcript.save
#        format.html { redirect_to @transcript, notice: 'Transcript was successfully created.' }
#        format.html { redirect_to @transcript, notice: '議事録の登録に成功しました.' }
        flash[:notice] = "議事録の登録に成功しました"
        redirect_to :action => 'list'
#        format.json { render :show, status: :created, location: @transcript }
      else
         render :action => 'new'
#        format.html { render :new }
#        format.json { render json: @transcript.errors, status: :unprocessable_entity }
      end
#    end
  end

  # PATCH/PUT /transcripts/1
  # PATCH/PUT /transcripts/1.json
  def update
    respond_to do |format|
      if @transcript.update(transcript_params)
        format.html { redirect_to @transcript, notice: 'Transcript was successfully updated.' }
        format.json { render :show, status: :ok, location: @transcript }
      else
        format.html { render :edit }
        format.json { render json: @transcript.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transcripts/1
  # DELETE /transcripts/1.json
  def destroy
    @transcript.destroy
    respond_to do |format|
      format.html { redirect_to transcripts_url, notice: 'Transcript was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transcript
      @transcript = Transcript.find(params[:id])
    end

    def get_taglist
#      @transcript_tags = @transcripts.find  :all, :select =>'tag', :group =>'tag' 
#      @transcript_tags =  Transcript.find( :all,  :select=>'tag', :group=>'tag' )
#      @transcript_tags =  Transcript.where("tag not ?",nil)

#      @transcript_tags =  Transcript.select(:id, :tag)  # display available
      @transcript_tags =  Transcript.select( :tag).group( :tag )

#      @transcript_tags =  Transcript.all.group(:tag)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transcript_params
      params.require(:transcript).permit(:title, :filename, :file, :content_type, :description, :tag, :user_id, :imagefile)
    end

end
