class OutflowsController < ApplicationController
  def show
  	@outflow = Outflow.find(params[:id])
  end
  
  def index
  	@outflows = Outflow.all		
  end

  def new
    @outflow = Outflow.new 
  end

  def search_between_dates
    if params[:initial_date] != "" || params[:ending_date] != ""
  	 initial_date = Date.parse(params[:initial_date])
      ending_date = Date.parse(params[:ending_date])
      @sales = Sale.where(:created_at => initial_date.beginning_of_day..ending_date.end_of_day)
      render 'report'
    else
      flash[:danger] = "Ingrese una fecha correcta"
      #@sales = Sale.all
      render 'report_search'
    end
  end
  
  def report_search
  end
end
