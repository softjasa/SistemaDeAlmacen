class IncomesController < ApplicationController
  def show
  	@income = Income.find(params[:id])
  end
  
  def index
  	@incomes = Income.all		
  end

  def new
    @income = Income.new  
  end


    def search_between_dates
  	initial_date = Date.parse(params[:initial_date])
    ending_date = Date.parse(params[:ending_date])
    @incomes = Income.where(:created_at => initial_date.beginning_of_day..ending_date.end_of_day)
    render 'report'
  end

    def report_search
    end


end
