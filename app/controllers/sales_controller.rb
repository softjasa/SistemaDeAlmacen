class SalesController < ApplicationController

  def index
    @sales = Sale.paginate(:per_page => 5, :page => params[:page])
  end

  def show
    @sale = Sale.find(params[:id])
    if params[:name] == nil
      @subproducts = Subproduct.paginate(:per_page => 5, :page => params[:page])
    else
      #@subproducts = Subproduct.where({name: "#{params[:name]}"}).paginate(:per_page => 5, :page => params[:page])
      @subproducts = Subproduct.where("name like ?", "%#{params[:name]}%").paginate(:per_page => 5, :page => params[:page])
    end
  end

  def egresos
    @sales = Sale.all
    @subproducts = Subproduct.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new
    @sale.price =  params[:price]
    @sale.confirmed =  params[:confirmed]
    @sale.check_number =  params[:check_number]
    @sale.client_name =  params[:client_name]
    @sale.nit =  params[:nit]
    if @sale.save   
      redirect_to @sale
    else
      flash[:message] = "Verifique los Campos Marcados"
      render :action => 'new'
    end
  end

  def edit
    @sale = Sale.find(params[:id])
  end

def update
		@sale = Sale.find(params[:id])
    @sale.confirmed = true
    @sale.client_name = Client.where("nit = :nit", {nit: params[:sale][:nit]}).to_a.at(0).name
    if @sale.update_attributes(params[:sale])
      @sale.confirm_sale
      @sale.save
      flash[:success] = "Venta Confirmada"
      redirect_to @sale
    else
      render 'edit'
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @productsales = Subproduct.all
    @productsales.each do |subproducto|
      if subproducto.sale_id == @sale.id
        subproducto.sale_id = nil
        subproducto.available = true
        subproducto.save
      end
    end
    @sale.destroy
    flash[:notice] = "Venta Cancelada"
    redirect_to sales_url
  end

  def cancel_sale
    @sale = Sale.find(params[:id])
    @subproducts = Subproduct.all
    @subproducts.each do |subproducto|
      if subproducto.sale_id == @sale.id
        subproducto.sale_id = nil
        subproducto.available = true
        subproducto.save
      end
    end
    @sale.destroy
    flash[:notice] = "Venta Cancelada"
    redirect_to sales_url
  end

  def destroyer
    @sale = Sale.find(params[:deletor])
    @sale.destroy
    flash[:notice] = "Venta Cancelada"
    redirect_to sales_url
  end

  def search
    @sales = buscar(params[:name]).paginate(:page => params[:page], :per_page => 6 )
    #@sales = Sale.where("client_name like ?", "%#{params[:name]}%").paginate(:per_page => 3, :page => params[:page])
    render 'index'
  end

  def buscar(nombre)
      items = Array.new 
      aux = Sale.all
      if nombre != "" && nombre != nil
          aux.each do |item|
          if (item.correspondeACliente(nombre))
              items.push(item)
          end
        end
      else
          items = aux
      end
      return items
    end

    def searchProduct
      @sales = buscarProd(params[:producto]).paginate(:page => params[:page], :per_page => 6 )
      render 'index'
    end

    def buscarProd(nombre)
      items = Array.new 
      aux = Sale.all
      if nombre != "" && nombre != nil
          aux.each do |item|
          if (item.tieneAlProducto(nombre))
              items.push(item)
          end
        end
      else
          items = aux
      end
      return items
    end

    def report
    end

    def searchDate
      if params[:date] != "" 
        selected_date = Date.parse(params[:date])
        @sales = Sale.where(:created_at => selected_date.beginning_of_day..selected_date.end_of_day).paginate(:page => params[:page], :per_page => 6 )  
        render 'index'
      else
        flash[:danger] = "Ingrese una fecha correcta"
        @sales = Sale.paginate(:page => params[:page], :per_page => 6 )
        render 'index'
      end
      
      
    end

    def report_search
    end

    def search_between_dates
      if params[:initial_date] != "" || params[:ending_date] != ""
        initial_date = Date.parse(params[:initial_date])
        ending_date = Date.parse(params[:ending_date])
        @sales = Sale.where(:created_at => initial_date.beginning_of_day..ending_date.end_of_day)
        @total = obtain_total(@sales)
        render 'report'
      else
        flash[:danger] = "Ingrese una fecha correcta"
        #@sales = Sale.all
        render 'report_search'
      end
    end

    def daily_report
      @sales = filter_by_date(Time.now)
      @total = obtain_total(@sales)
    render 'report'
    end

    def weekly_report
      @sales = week
      @total = obtain_total(@sales)
    render 'report'
    end

    def monthly_report
      @sales = month
      @total = obtain_total(@sales)
    render 'report'
    end

    def anual_report
      @sales = year
      @total = obtain_total(@sales)
      render 'report'
    end

    def year
      items = Array.new
      aux = Sale.all
      items = aux.where("created_at > ? AND created_at < ?", Date.today.beginning_of_year, Date.today.end_of_year)
      return items
    end

    def month
      items = Array.new
      aux = Sale.all
      items = aux.where("created_at > ?", DateTime.now.beginning_of_month)
      return items
    end

    def week
      items = Array.new
      aux = Sale.all
      items = aux.where(["created_at >= ?", 7.days.ago])
      return items
    end

    def filter_by_date(date)
      items = Array.new
      aux = Sale.all
      items = aux.where(["created_at >= ? AND created_at <= ?", date.beginning_of_day, date.end_of_day])
      return items
    end

    def obtain_total(sales)
      aux = 0
      sales.each do |sale|
        aux = aux + sale.price
      end
      return aux
    end

end
