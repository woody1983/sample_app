class ColumnsController < ApplicationController

def create
    @table = Table.find(params[:table_id])
    @column = @table.columns.create(params[:column])
    flash[:success] = "Column is created."
    redirect_to table_path(@table)
 end

end

