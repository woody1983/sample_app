class TablesController < ApplicationController

def index
    #@tables = Table.paginate(table: params[:table])
 end

def create
    @database = Database.find(params[:database_id])
    @table = @database.tables.create(params[:table])
    flash[:info] = "Table is created."
    redirect_to database_path(@database)
 end

 def show
  @tables = Table.find(params[:id])
  @databases = Database.all
    respond_to do |format|
    format.html  # show.html.erb
    format.json  { render :json => @tables }
  end
 end

 def edit
    @tables = Table.find(params[:id])
 end

 def update
    @tables = Table.find(params[:id])
    if @tables.update_attributes(params[:table])
      flash[:success] = "Table updated"
      redirect_to @tables
    else
      render 'edit'
    end         
  end

  def destroy
  @tables = Table.find(params[:id])
  @databases = Database.find_by_id(@tables.database_id)
  @tables.destroy
  
  redirect_to database_path(@databases) 
  end

end


