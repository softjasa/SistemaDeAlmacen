class ClientsController < ApplicationController

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      flash[:success] = "Cliente registrado!"
      redirect_to '/clients'
    else
      render :action => 'new'
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      flash[:success] = "Cliente modificado!"
      redirect_to '/clients'
    else
      render :action => 'edit'
    end
  end

  def index
    @clients = Client.paginate(:per_page => 6, :page => params[:page])
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    flash[:danger] = "Cliente eliminado!"
    redirect_to :controller => :clients, :action => "index"
  end

  def search
    #@clients = buscar(params[:name])
    @clients = Client.where("name like ?", "%#{params[:name]}%").paginate(:per_page => 6, :page => params[:page])
    render 'index'
  end

  def buscar(nombre)
      items = Array.new 
      aux = Client.all
      if nombre != "" && nombre != nil
          aux.each do |item|
          if (item.correspondeAnombre(nombre))
              items.push(item)
          end
        end
      else
          items = aux
      end
      return items
    end
end
