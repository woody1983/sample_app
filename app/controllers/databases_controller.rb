class DatabasesController < ApplicationController
  def new
    @database = Database.new
  end

  def create
    @databases_create = Database.new(params[:database])
    if @databases_create.save
       @databases = Database.all
       redirect_to @databases_create
    else
      render 'new'
    end
  end

  def show
    @databases = Database.find(params[:id])
    @databases_table = Database.find(params[:id])
    
    @databases_list = Database.all

  respond_to do |format|
    format.html  # show.html.erb
    format.json  { render :json => @databases }
  end
  end

  def edit
  end

  def update
    @databases = Database.find(params[:id])
    if @databases.update_attributes(params[:database])
      flash[:success] = "Database info updated"
      redirect_to @databases
    else
      render 'show'
    end         
  end

  def index
    @databases = Database.all
    #@dba = User.find(@databases.db_user)
    ##@databases.db_user = @dba.name
    @database = Database.new  ##-->for index create button
    respond_to do |format|
    format.html  # index.html.erb
    format.json  { render :json => @databases }
    end
  end
end
 
