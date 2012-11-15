class CirclesController < ApplicationController
  def create
      @table = Table.find(params[:table_id])
      @circles = @table.circles.create(params[:circle])
      flash[:success] = "Circle is created."
      redirect_to table_path(@table)
    end
end
